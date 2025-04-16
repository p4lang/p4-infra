// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef P4_INFRA_P4_PDPI_IR_PROPERTIES_H_
#define P4_INFRA_P4_PDPI_IR_PROPERTIES_H_

#include "p4_pdpi/ir.pb.h"

namespace pdpi {

// Returns true if `match_field` can be absent in a table entry.
bool IsOmittable(const IrMatchFieldDefinition& match_field);

// Returns true if `match_field` has a P4Runtime-translated translated type,as
// expressed through an @p4runtime_translation annotation.
bool HasP4RuntimeTranslatedType(const IrMatchFieldDefinition& match_field);

// Returns true if `param` has a P4Runtime-translated type, as expressed through
// an @p4runtime_translation annotation
bool HasP4RuntimeTranslatedType(
    const IrActionDefinition::IrActionParamDefinition& param);

}  // namespace pdpi

#endif  // P4_INFRA_P4_PDPI_IR_PROPERTIES_H_

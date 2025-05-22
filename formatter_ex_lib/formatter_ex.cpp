#include "formatter_ex.h"

#include "/home/artyom/lab03/formatter_lib/formatter.h"

std::ostream& formatter(std::ostream& out, const std::string& message)
{
    return out << formatter(message);
}

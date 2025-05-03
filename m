Return-Path: <linux-hyperv+bounces-5340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28510AA82C8
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9491846051B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA661A841C;
	Sat,  3 May 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ7YSeyc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C01CD0C;
	Sat,  3 May 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746304402; cv=none; b=B9PqjWlsnOr9R7AJ9CPUptaayf4LTf31jp/fdhISdiX2IpRSu/oXuss6nYhTAF++ciiEJYvsOQZTDTlpyin3AgPDy1jbi0RRQf7dZyVVXFm/002q0YaEkpBRbGKs7me4TbNd+EdRBBrKXBvxtZbkI72rCEqHeSl3yPxaFGdIL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746304402; c=relaxed/simple;
	bh=lzIwPmqPMdz3XojcJkKNZG+joQBPqTC3+fqltwxxtFQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=D+aF0nKrzZfOnkagcepyYW9eTUKLXx1o4uZ0ltRGn+1iBgJsWoUe8p9LO6pO2AalFpLuyCjlf5bjcqE88NB7b/EkmHNV1LkBMgzcvkAQDbJDYHoQxzf0HSXCQMoOW0hQw9yGV4qgKWREbO0c7x9YcgII37LtaX06LLHw20AdfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ7YSeyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A15BC4CEE3;
	Sat,  3 May 2025 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746304401;
	bh=lzIwPmqPMdz3XojcJkKNZG+joQBPqTC3+fqltwxxtFQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vQ7YSeycPSASlx4k6K6opncdc46F2A6XnMD8LkzQ8Qn8O5iGgrJ8IpAH87+kUlPwx
	 /zBmQ5JQzrWoPKSKgj935gVZVLdNCo3Au4HBhVtfCGKWFi/HpLuK6MJlb4b4KpAKVm
	 yLZW1j4gRYNUOlWC0IL0+u7ee40wKdAvmHzZaO2BOY6/1f8ia9pQWhc7traWGLhibv
	 E9mwYR8R03GvBVDJ6uqc0PH4SzRxFH9M71zOTYuaFK9TpkK7206ZcrQEsh4LZPVlag
	 viOSBDMfMjlxFj0k29M9jlatfoU1/AS1blG1L7YQ+05JWE/lEeK9ZPbtIQx+nqDZNK
	 4jXC06ppAY2cQ==
Date: Sat, 03 May 2025 15:33:19 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Wei Liu <wei.liu@kernel.org>, 
 linux-acpi@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
Message-Id: <174630439938.1202156.1298422301463941407.robh@kernel.org>
Subject: Re: [PATCH v3 04/13] dt-bindings: x86: Add CPU bindings for x86


On Sat, 03 May 2025 12:15:06 -0700, Ricardo Neri wrote:
> Add bindings for CPUs in x86 architecture. Start by defining the `reg` and
> `enable-method` properties and their relationship to x86 APIC ID and the
> available mechanisms to boot secondary CPUs.
> 
> Start defining bindings for Intel processors. Bindings for other vendors
> can be added later as needed.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/x86/cpus.example.dtb: cpus: cpu@0: 'cache-level' is a required property
	from schema $id: http://devicetree.org/schemas/cpus.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



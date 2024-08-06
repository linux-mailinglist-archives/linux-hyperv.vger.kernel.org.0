Return-Path: <linux-hyperv+bounces-2740-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E6949C5C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 01:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049E9282D7B
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EA17625B;
	Tue,  6 Aug 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2ScBFah"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027739FE4;
	Tue,  6 Aug 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722987507; cv=none; b=fihVs1I9oxkEfwEbHVS7z6+fGs+5gp2wmB6X+KwADjA6Pn3VS9XrzH6RKNjSdzDxsxTBmaxZW5O2osJiH7HjjmewHZzfJTor9i9aoaiDcinBhdkj1x5mHEGoF3v2eUfvFrscDhTKqjcgF/gcaEfRm8V0SXx3ohu/DXdJy7jp7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722987507; c=relaxed/simple;
	bh=sllvMRONd5dLDy11qt41CSgvoPDwkmpySOxYlwuKFl8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SYTROjSlAE5fvgrO9S1GEW8NdZuHGWqOIzUIUNZd0F0lJqYO9Y3ktgHFmQT+lCaZFyWfRXpRaYeLZnQmJ4nsWa6757oRo1ehAW5Lm0ZpP+5K6UWJfh3R+/XHNTeJYRdHpUcizd6Il+xQkW/NdMfukNa1nX5js8hT8op1yCgO+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2ScBFah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76694C32786;
	Tue,  6 Aug 2024 23:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722987506;
	bh=sllvMRONd5dLDy11qt41CSgvoPDwkmpySOxYlwuKFl8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r2ScBFahMGDxLt23xL1++2dAgjYj94CYWp6hBgwJqSCYauhVY/F0eB0kragCiKR6t
	 WYyMkfVZXo+ldyW99KoSSulk/ihFP1gk+MtFRzaX9iIsrYhR5AmWDAOWT5ZxBFyff0
	 gUfY5HMcf0Y5kyQT/UOC6pDbA+A+frhGQ7VybI2ogkOd/MaghjlYPRKZ5YK/Gp0cVV
	 hXEGVNvz0qGES9whQySpwDxCcJd/IoJJ8UF5Un9eanIRsoi8BQf4pEM68vg5mxMa3j
	 kayHImcV1ealn2S+bp9dh3vv055MugLin/GtvyJiealBx96uRlsyaVi7GoidhcnNwi
	 nncEFBcTfKd+Q==
Date: Tue, 06 Aug 2024 17:38:25 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 haiyangz@microsoft.com, krzk+dt@kernel.org, x86@kernel.org, 
 wei.liu@kernel.org, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
 hpa@zytor.com, linux-kernel@vger.kernel.org, bp@alien8.de, 
 tglx@linutronix.de, mingo@redhat.com, rafael@kernel.org, kys@microsoft.com, 
 kirill.shutemov@linux.intel.com, conor+dt@kernel.org, lenb@kernel.org, 
 decui@microsoft.com
In-Reply-To: <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
Message-Id: <172298750308.229414.6420535043181861002.robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: x86: Add ACPI wakeup mailbox


On Tue, 06 Aug 2024 15:12:32 -0700, Yunhong Jiang wrote:
> Add the binding to use the ACPI wakeup mailbox mechanism to bringup APs.
> 
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  .../devicetree/bindings/x86/wakeup.yaml       | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: [error] syntax error: expected '<document start>', but found '<block mapping start>' (syntax)
./Documentation/devicetree/bindings/x86/wakeup.yaml:41:111: [warning] line too long (153 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/x86/wakeup.example.dts'
Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: did not find expected <document start>
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/x86/wakeup.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: did not find expected <document start>
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/x86/wakeup.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240806221237.1634126-3-yunhong.jiang@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



Return-Path: <linux-hyperv+bounces-685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD357E09FF
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 21:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F7E1C20A21
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE992375A;
	Fri,  3 Nov 2023 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="iWxQzWxW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FF2110F
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 20:16:07 +0000 (UTC)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05EB8;
	Fri,  3 Nov 2023 13:16:05 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3InTir026999;
	Fri, 3 Nov 2023 20:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=L0vesmfq1HuNLBuf10D6DYelylk7j7jtVX78DuGz6M4=;
 b=iWxQzWxWxdg01AW5ZkknyW0p54Dl7PQ37JRPo/7Oj6xqCJH8BpGMgwPJPFkbGmg3QQA0
 rWzEK92rzFyLruSmbC/d5aVToYuKeQ2WBEdpfOsb0Rf6eV87qUZ+ue1h70Oa3i1mNo+g
 OrEAYB+Os5JL4lxb2jf6SzZjvdyJCjNddBMF4rEVRGQfBYoZ02iC8fEVQQEKtw9QCSQ+
 27T5Vc5Mg8gJaOuAT6xPWF6vWVpJZtKcIPow94M9IRDYBnS/ac/wBPZ8lm+iznBDKHjH
 LFKSK/oI3MFJ+czPAuBirnM2FkX09gd4e2LNwMwezmsDQyTF4u+H9eURB5KI1K2I3UlN zg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u519dvh0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Nov 2023 20:15:17 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 23029131AC;
	Fri,  3 Nov 2023 20:15:16 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 4BBB2807418;
	Fri,  3 Nov 2023 20:15:13 +0000 (UTC)
Date: Fri, 3 Nov 2023 15:15:11 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/apic: Drop apic::delivery_mode
Message-ID: <ZUVUz8P6a0mzVsJP@swahl-home.5wahls.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
 <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
X-Proofpoint-ORIG-GUID: FnFAgYD2Q1gW-8ZQ1sJxC5P3qp4qrjnK
X-Proofpoint-GUID: FnFAgYD2Q1gW-8ZQ1sJxC5P3qp4qrjnK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030170

On Thu, Nov 02, 2023 at 12:26:19PM +0000, Andrew Cooper wrote:
> This field is set to APIC_DELIVERY_MODE_FIXED in all cases, and is read
> exactly once.  Fold the constant in uv_program_mmr() and drop the field.
> 
> Searching for the origin of the stale HyperV comment reveals commit
> a31e58e129f7 ("x86/apic: Switch all APICs to Fixed delivery mode") which
> notes:
> 
>   As a consequence of this change, the apic::irq_delivery_mode field is
>   now pointless, but this needs to be cleaned up in a separate patch.
> 
> 6 years is long enough for this technical debt to have survived.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

Reveiewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
>  arch/x86/include/asm/apic.h           | 2 --
>  arch/x86/kernel/apic/apic_flat_64.c   | 2 --
>  arch/x86/kernel/apic/apic_noop.c      | 1 -
>  arch/x86/kernel/apic/apic_numachip.c  | 2 --
>  arch/x86/kernel/apic/bigsmp_32.c      | 1 -
>  arch/x86/kernel/apic/probe_32.c       | 1 -
>  arch/x86/kernel/apic/x2apic_cluster.c | 1 -
>  arch/x86/kernel/apic/x2apic_phys.c    | 1 -
>  arch/x86/kernel/apic/x2apic_uv_x.c    | 1 -
>  arch/x86/platform/uv/uv_irq.c         | 2 +-
>  drivers/pci/controller/pci-hyperv.c   | 7 -------
>  11 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 5af4ec1a0f71..841afbd7bfe7 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -272,8 +272,6 @@ struct apic {
>  	void	(*send_IPI_all)(int vector);
>  	void	(*send_IPI_self)(int vector);
>  
> -	enum apic_delivery_modes delivery_mode;
> -
>  	u32	disable_esr		: 1,
>  		dest_mode_logical	: 1,
>  		x2apic_set_max_apicid	: 1;
> diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
> index 032a84e2c3cc..e526b226910b 100644
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -82,7 +82,6 @@ static struct apic apic_flat __ro_after_init = {
>  	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
>  	.apic_id_registered		= default_apic_id_registered,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= true,
>  
>  	.disable_esr			= 0,
> @@ -153,7 +152,6 @@ static struct apic apic_physflat __ro_after_init = {
>  	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
>  	.apic_id_registered		= default_apic_id_registered,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
> index 966d7cf10b95..70e7dfc3cc84 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -45,7 +45,6 @@ static void noop_apic_write(u32 reg, u32 val)
>  struct apic apic_noop __ro_after_init = {
>  	.name				= "noop",
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= true,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
> index 63f3d7be9dc7..8f5a42ad1f9f 100644
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -222,7 +222,6 @@ static const struct apic apic_numachip1 __refconst = {
>  	.probe				= numachip1_probe,
>  	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 0,
> @@ -259,7 +258,6 @@ static const struct apic apic_numachip2 __refconst = {
>  	.probe				= numachip2_probe,
>  	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
> index 0e5535add4b5..863c3002a574 100644
> --- a/arch/x86/kernel/apic/bigsmp_32.c
> +++ b/arch/x86/kernel/apic/bigsmp_32.c
> @@ -80,7 +80,6 @@ static struct apic apic_bigsmp __ro_after_init = {
>  	.name				= "bigsmp",
>  	.probe				= probe_bigsmp,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 1,
> diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
> index 9a06df6cdd68..f851ccf1e14f 100644
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -35,7 +35,6 @@ static struct apic apic_default __ro_after_init = {
>  	.probe				= probe_default,
>  	.apic_id_registered		= default_apic_id_registered,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= true,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
> index affbff65e497..7d15f6c3b718 100644
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -227,7 +227,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
>  	.probe				= x2apic_cluster_probe,
>  	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= true,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
> index 788cdb4ee394..8bb740e22b7d 100644
> --- a/arch/x86/kernel/apic/x2apic_phys.c
> +++ b/arch/x86/kernel/apic/x2apic_phys.c
> @@ -145,7 +145,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
>  	.probe				= x2apic_phys_probe,
>  	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 7d304ef1a7f5..ae4f0c1a7b43 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -805,7 +805,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
>  	.probe				= uv_probe,
>  	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
>  
> -	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
>  	.dest_mode_logical		= false,
>  
>  	.disable_esr			= 0,
> diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
> index 4221259a5870..a379501b7a69 100644
> --- a/arch/x86/platform/uv/uv_irq.c
> +++ b/arch/x86/platform/uv/uv_irq.c
> @@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
>  	mmr_value = 0;
>  	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
>  	entry->vector		= cfg->vector;
> -	entry->delivery_mode	= apic->delivery_mode;
> +	entry->delivery_mode	= APIC_DELIVERY_MODE_FIXED;
>  	entry->dest_mode	= apic->dest_mode_logical;
>  	entry->polarity		= 0;
>  	entry->trigger		= 0;
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bed3cefdaf19..f5d2ef8572e7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -650,13 +650,6 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  			   PCI_FUNC(pdev->devfn);
>  	params->int_target.vector = hv_msi_get_int_vector(data);
>  
> -	/*
> -	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
> -	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
> -	 * spurious interrupt storm. Not doing so does not seem to have a
> -	 * negative effect (yet?).
> -	 */
> -
>  	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
>  		/*
>  		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
> 
> -- 
> 2.30.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise


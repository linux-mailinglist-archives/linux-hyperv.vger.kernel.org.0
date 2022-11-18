Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8C62EC0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Nov 2022 03:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiKRCl3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Nov 2022 21:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRCl2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Nov 2022 21:41:28 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022018.outbound.protection.outlook.com [52.101.53.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99A6E545;
        Thu, 17 Nov 2022 18:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imwLNDaK9GRU6iIY0JjwgNSfK7BTmriEEdgLgsE+eCf1SY07ZcjV6yzzP4ThEyVA9MwH/KWtxwDToq+DspcWIW4Pk/xpevqncexfSrmYRYaqm/VX+ohuWEvHE49hklmNsfFfJE9Xt4Mwu+Cl1QHP4aL6GTRL+oIY2Mhifwu2ztc93aFUKtkhWL33dKEeAAXPzdhm/l+gead62kgk8Sd5ecGMC5pzvU+tOVQhlvPGzNkyGRSH4DSvZs5fQttkEsNLDknBtPvLLFwx5gYXucs/spWGhR3Yy3kRuq+xVEieHSUrgFVbN/yFHNQvaOzGxk2oODPrLX7xd7jugx7aKIpcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQHJ1tolK589BmnhYUrlUJB6WT8ipEZGt4I1P5ou5iM=;
 b=iCMXM0kYqmoIlMmJpdAByWYIAMLpYXrXLZlrbS6lhFkUZuXSpDOBXSVaiOu5PpLBFWz2j17uoE834BFXAffk65WEifpejJBISl19NH6fKOe8Akrb0qvsHGvZGwozmOUxCyPUSiC7iTuxVziMPkYkwvIl0DhE6A49w2vfy6Do7UL4d69AXUGvgTNdu8rfVf2AoLN+CbOflAAemTRAa4C6jBPk6fanMDyhTo0g19yKkeS3fIHOtBBfBxrS3DEzuiJ5rADbC/ljRfXHa9TiXtL7ypVb+vZ9zEUlfiOKwmAb5Efg93V/MlTFJS0/Jr23atlz/Jv+cnVEaWEVfwQEb+oVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQHJ1tolK589BmnhYUrlUJB6WT8ipEZGt4I1P5ou5iM=;
 b=IfH6tBHJlvIfyMhBMMsn+ean3kw1RNsaNI1fdyob7nYcqCZ6zZKHyn7I9QvCIykJIlOrtq/Jhfl6Cssyh6XeWl/pwHdO7Px3VMFALa/GoWMUQkJFyacugmQqE/Sltlcff1M7tkf16XEOOELV25G+dfjL9IQrf+IurQ43929P5x4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3705.namprd21.prod.outlook.com (2603:10b6:8:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.6; Fri, 18 Nov
 2022 02:41:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 02:41:22 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
Thread-Topic: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
Thread-Index: AQHY+sDTpXRY2UdKo0SkUw89BRv/q65D+NXg
Date:   Fri, 18 Nov 2022 02:41:22 +0000
Message-ID: <BYAPR21MB1688A32190EB90A509307244D7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ddae3c36-cfa4-4730-add9-cec27f0e45ce;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T02:40:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3705:EE_
x-ms-office365-filtering-correlation-id: 945a5c17-4a78-4183-e1d7-08dac90e6142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y270AHT/G6O9XiO8qGgbJLrkxyOmywyMvCXdjjLel/7s1B0fU8WlkWHFBRPp9cIAkpYudle7v27/J7HPqGccOsUHeuwWl6yxhv/QF1QEpUs94mZr34omlWNhtmrod5J05UR9Gu7W5N0QiOCWIdNS+jsdjwtwg2mKldtSNpTY2Dva2/tDhSY4h8eE4n2D6fwWNR/xuLYSJNk1U/dYiF80IX+ROV0JpSIugA8C7WKuSjk7BROlGdx4oGkegoph3Nage8zJUD3Wjz+drAT8vbmC3KrHLmVcYTMAftKD/wF19EF+aRpM9+xtqCI8yJ/X1X5fae2rDbnVH2ryznVOej0f7r7rzJ4hOXgjfM9ZKT1jkQN0PrTzm+P3c4DdhdzXbbuX41U463W5XsA47zLXUgCCxW+6i0PmW/5lVAotAxlBLFBgx8KLo8FfKsvaQ28Xr+YN27LnKGOlAUsaLYwHh6Px3nkRRu2qbV38Waw5MMSjo6Yh2nBPhtulXvmvtSpTGapebPXUzTvF0tx9ghHf5k6kvZO7goMqtybpb0TPp9wcELW7FsDINJHEY5jQWcu+HcJ77P85FnH0AvRaJninXgaj4qr6j4F4tlCtXQd/nTUx/kcVHZp84KJEXXh/4eOtXrfcxTt1q5E9GUhBADo+OdzdDTHEx6IovvH7CFUlGfoqZ6SlimMmfgqllqHEDkZQvj59GgV3U3738Ar/h4sJl8L3LJ0EYNCGXn2q6cHDps6SO7RFjw+f4EYt384AZ1mItyeZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(478600001)(71200400001)(7696005)(6506007)(110136005)(10290500003)(54906003)(316002)(26005)(9686003)(76116006)(41300700001)(66446008)(66556008)(64756008)(4326008)(66476007)(66946007)(8676002)(55016003)(8936002)(5660300002)(38100700002)(83380400001)(52536014)(186003)(38070700005)(2906002)(82960400001)(82950400001)(33656002)(8990500004)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJoJLcnYzzkbtilgrg2ZpD5kHAlV/v3O1jBxwY0xUyhUcDH2tYIVMb3oEcfu?=
 =?us-ascii?Q?8CyDLFX/hDVPdx4Xi03Jd3OC9D43sPIh1YpY1O54mubgwjbswcbAUmL9siuB?=
 =?us-ascii?Q?CkDrdCzdymPfNS7//2rfnzO6RJoeOjbedTZi+rrNEP62dXTW2UTVVNZSdHfY?=
 =?us-ascii?Q?wuOwE+OLAVBGTBo7/27H/tiwyBaKDrmLhNTGmLYT02ZcvMKEZZtGmCHoucK1?=
 =?us-ascii?Q?SeRD29V4H+QZhwOdMXdIXflBf6KYjyC3nXk+6mj+dOWmyU9vaMnE7hE4GsBC?=
 =?us-ascii?Q?bneCl2rEtKencWIG29OIzf6o4PMB8ZEDG97Y/ELVNaTNBa1Dg83qHVoqma4q?=
 =?us-ascii?Q?Aw2M01Tl2tV/eHvNgtdie9u4dNWAz+HV0BzDBSaLxojCKrTqi0XvYYeyicOm?=
 =?us-ascii?Q?2aeypk9uMZfxFwGiI8TAMIVmNcM1am2529N060J7hThTNHS67UnR/bb8IxRm?=
 =?us-ascii?Q?d5RgmeqR2kIL/vg6/f6OEjv89NsdGyJFaC+e5+SBQKsFt/EacwJI/UbTbl7H?=
 =?us-ascii?Q?Y+KtWAhEOK5PqYsjVtWdWn5YGS3LyfCde6RUaJL26XHKkE5b39NjMLkznji2?=
 =?us-ascii?Q?M/5SRLr+bP8m4OGTNhte4srD5JETxRCp9jVgx1i+0W7LFo5yvNMC1Eo2M7E7?=
 =?us-ascii?Q?Y6YQveyWhu+2MO2DElmfOS81dH+pGe/EwpZpkXjTCCyYCuUhbtOQ1MJUS6D5?=
 =?us-ascii?Q?CtkdDR+IbLBxkp1apUZCqtEpcwlAfbk3F6FG1AjFj4dq+GGL0VpkO+PglB8P?=
 =?us-ascii?Q?Ka171iBD/PcaYWdmrEaNdGVPvaUuQcDkt6GQQSojp9UbPzt7+wCHsQIRs5DM?=
 =?us-ascii?Q?eTjFrKdWq1fci1FYoSNob6ljiBZL241/7g0/7gdUXgSHr3S0mhIBSWMvZmwe?=
 =?us-ascii?Q?EWak+u3rojR9Gk5Cf/WT61gRPdW23M5FvdixUlM+ChHNhQsLa4EV8JpTtj+G?=
 =?us-ascii?Q?nKIMdQiPtSFWfWvfLSJymmF9h8mlx91B7zVThdszIR9l6fSeklplrldBuGqs?=
 =?us-ascii?Q?le0J9Qgollc5y2MMY3r5S/PbMn+UOX1529wr7Rlk+gYq4glPnaY8bRGh7oRG?=
 =?us-ascii?Q?JDh6ivNe+WsjZicNPvKBGaOfNbvUvYD2tx95Ll/psAyEEooICVIM9ARDHiud?=
 =?us-ascii?Q?UE7KDPdHIAWlJ+BmAxoCzCHAkT9L3wqW4gs6S+9gkR4gnRx3V33iEnyYYViL?=
 =?us-ascii?Q?1WXsZYaZbmzKAS6xTJDwgodeWjjOOOYn73Ed2G3RMQcz8KV/63lhPLDCyncu?=
 =?us-ascii?Q?MOu1dWtX5TZgKlr60OEJkNAe0+zrL3psKlj4VEduYxh1gzJP3vT2utuGrk8p?=
 =?us-ascii?Q?pT5l7WeMMquAbS+3rzfcXpvpVdaV97CN3fj8SGHj4wr6oheluP32MKyXkHCX?=
 =?us-ascii?Q?Cddd8OLQqw8COKKA4mC/S44r3hbT5ouAW7EuyngNdQ8z4XPP5zRwS4d99tB8?=
 =?us-ascii?Q?qy7Y5NwOova1Q2HEwiEQI4IDFIw8nv1cyNZE+vKuiYnyaE5YFbpplumXn3wm?=
 =?us-ascii?Q?Xa9lZSsXGc9L0lIONoCYUPzjKSZwvZlX8b1NlaGvfeczzpbnB3YK3g8jU5qy?=
 =?us-ascii?Q?kxSjCue7S0+AZ3kSCyEPvAhrJZvcmuSJ6t0ZoLvfMlwt6nxUFN3WMeWiFZJl?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945a5c17-4a78-4183-e1d7-08dac90e6142
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 02:41:22.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TypYE6jVKktBSvpQI75XccmLTivA2ogfbu3EYtIWOYUg0a5n8YZ9lZ+u6vZ2K6+A+OIjGQJJAzrbHF6y9keAb1UUzeEC2z95MahEU7TUt80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3705
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 17, 2022 12:12 PM
>=20
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
>=20
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
>=20
> Tested with root and non-root hyperv partitions.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |  6 ++++++
>  drivers/iommu/Kconfig          |  6 +++---
>  drivers/iommu/hyperv-iommu.c   | 11 ++++++++---
>  3 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 831613959a92..46668e255421 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -475,6 +475,12 @@ static bool __init ms_hyperv_x2apic_available(void)
>   * (logically) generates MSIs directly to the system APIC irq domain.
>   * There is no HPET, and PCI MSI/MSI-X interrupts are remapped by the
>   * pci-hyperv host bridge.
> + *
> + * Note: for a Hyper-V root partition, this will always return false.
> + * The hypervisor doesn't expose these HYPERV_CPUID_VIRT_STACK_* cpuids =
by
> + * default, they are implemented as intercepts by the Windows Hyper-V st=
ack.
> + * Even a nested root partition (L2 root) will not get them because the
> + * nested (L1) hypervisor filters them out.
>   */
>  static bool __init ms_hyperv_msi_ext_dest_id(void)
>  {
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..cf7433652db0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -474,13 +474,13 @@ config QCOM_IOMMU
>  	  Support for IOMMU on certain Qualcomm SoCs.
>=20
>  config HYPERV_IOMMU
> -	bool "Hyper-V x2APIC IRQ Handling"
> +	bool "Hyper-V IRQ Handling"
>  	depends on HYPERV && X86
>  	select IOMMU_API
>  	default HYPERV
>  	help
> -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> -	  guests to run with x2APIC mode enabled.
> +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> +	  guest and root partitions.
>=20
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e190bb8c225c..8302db7f783e 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -122,9 +122,12 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	const char *name;
>  	const struct irq_domain_ops *ops;
>=20
> +	/*
> +	 * For a Hyper-V root partition, ms_hyperv_msi_ext_dest_id()
> +	 * will always return false.
> +	 */
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> -	    x86_init.hyper.msi_ext_dest_id() ||
> -	    !x2apic_supported())
> +	    x86_init.hyper.msi_ext_dest_id())
>  		return -ENODEV;
>=20
>  	if (hv_root_partition) {
> @@ -170,7 +173,9 @@ static int __init hyperv_prepare_irq_remapping(void)
>=20
>  static int __init hyperv_enable_irq_remapping(void)
>  {
> -	return IRQ_REMAP_X2APIC_MODE;
> +	if (x2apic_supported())
> +		return IRQ_REMAP_X2APIC_MODE;
> +	return IRQ_REMAP_XAPIC_MODE;
>  }
>=20
>  struct irq_remap_ops hyperv_irq_remap_ops =3D {
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

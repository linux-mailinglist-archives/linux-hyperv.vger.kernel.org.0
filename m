Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216AC6260BE
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKR7A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiKKR67 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 12:58:59 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022022.outbound.protection.outlook.com [52.101.53.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E263BA2;
        Fri, 11 Nov 2022 09:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrDpHN0jlFS+2xDIL9quHkslqWkYiBGzZo6MTzDyOaOh4R/aqSP7pcY5dUvTZjHfCTslb+MIY44+itDoh2gM34wfASmX6JitLDCK48U7a94KVfIkUNwIucdWkJ1/vFkheXr+f1nocbrwvxhc2KueAKg/ow93NKfZVfjYncVpLJ/et8ZsCEaiFR/Apl/5n6pe4wWjhEdJwxZLDmLrM3CJPllQIm+wAOOI5zIk93yVEut9d3rW/ultkd3aYg7XEXLh3RAVglVOl0rJFzKK0kQfh7Fa99FJh8QPfca6clQEfpceVgg0V8kyMHoSMEH7SeGzbtPKUwrs6Hdb3WxpQJwwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkjoFDq8gaUH9ng48j01bFVZX9pCzC8iPt0Chn0sP2Q=;
 b=kpvm0h9zfgR8z/kXxtcwEvIFtPWlDY0AnE9s688nLUt0Z7AynbOIP+BinY6EhMGbd5eVuhzB3HS+FC3kfXjeXqCuTsA/tKfTifaVFRrezhXtkLAzDPOtVTJ2YGjX8Uq18CQ1HJkIqx5ZCflX6s0cePXBXu1QFfL6hCW1R2Q9NMs9TRZu+Ogo82Y8ulBBp3X8EsIPgEOSB488ZHu9UNwsA2oHG4hXS1Bi1nPkVrTvUDreiIbe66pI3d4ruwl4ggRy2rBF6M9schdrGUGPR9SlSXmJS7Vg3tNGFt1G4eMtiO86ectXE4ndmsdjcNgLrU8AlFBUMCdviofh9UzQ7FciCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkjoFDq8gaUH9ng48j01bFVZX9pCzC8iPt0Chn0sP2Q=;
 b=WjKv9Rb4396ayfpe146nwCzgZST8RvrB49zyRArS60/NAqA3BZix0NyowIusXIWFF4eEaj6okA5OyJCrzcnj3bSJzDPHpvuc4OOsT7WMFkCra0CDukYFVfeeCRrFe7cNilNl54zaoobrDh/b8Jk+UFxYV85ho/O2kU0EhXerwVA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1291.namprd21.prod.outlook.com (2603:10b6:510:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Fri, 11 Nov
 2022 17:58:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%7]) with mapi id 15.20.5813.015; Fri, 11 Nov 2022
 17:58:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Topic: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Index: AQHY9G6MTvL64VjEeUSlJ0XIa/5zY6457YUAgAAElfCAAAq9AIAAB60A
Date:   Fri, 11 Nov 2022 17:58:53 +0000
Message-ID: <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
In-Reply-To: <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=717aee75-fbc6-4d58-86c3-75827a242d47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-11T17:54:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1291:EE_
x-ms-office365-filtering-correlation-id: 8330db9f-bf79-46e2-4470-08dac40e655e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3jTSbF+bzgvjLNGA5Oa7FZFiKTV4QsDZrE9FtAsAJTZsR2vfAk7EB8SzcJru3TLvJt0ZKlmFBzB+184jfYiVhSpooJzQaZioqNXRcnFYzS+Tag7SnX0YT1zfdpUUYQ+ILXfZ8pVTYa/lZT7XzVr3BvPtaM8B3V7Bh5VgY/tkiOLk6HleeVzkfz52AXYvi83/T7JpmAdQH2KMYDdCogjpL6q0nKC1UuKStBEQhmLw83FGMHyrJxIkVji9VgeFtSgtBQWQ0nSnFmw9Z4jIdVHi4chUmp5GZsonNc/IdOjfHTtksJ+HljaGeveMzLbkm0rKV/b5vDC1rIMpfL8OV0+xmcXvm97tz3GEqsxRTeEwnyL3zyR/i+Lv47JbvBPJ8/QwHms6X4rlOu5epm/dOQa4qAddDg4Pox9JoQlI7ZdBCgLTPMCdzjXZjJyapNIMMTCsMQI4i+Myop8VCk5m/F3+hQ73wcW8M3EMudsyluT2MfypRDmFW3HddGeAis83NTQhiykeQNQ8vqK1j1OozM8n1dV58J8tHvmeLCnjBBeCsGxrIJsC8UcxlW+qsGQEnKFMjbgcwAfzzv2H2GhiXazfLOTzidOvup9ZbSil68uN/sGLv4ZS0YQu7ebn0tL9ALFDt43DFPedoHlc6YMOsltj3f/mi/LtJOi9+uaO2tK4tIxfMxsnEi8X+j8QZdv0xLBnUlS6dztTzVTpcVm12hfeuUG828FGFe+1Uf9TUW1GBrjsp+RWE7Eg7quQHXciNjkPoAZxuuATBkDRX2FanoClV3ALJKIzein74aZfgFLitFLJu1JJweKY2ji69iywLdP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(38070700005)(82950400001)(33656002)(86362001)(82960400001)(8936002)(6506007)(55016003)(2906002)(7696005)(9686003)(122000001)(83380400001)(186003)(6916009)(38100700002)(8990500004)(71200400001)(26005)(5660300002)(10290500003)(4326008)(76116006)(52536014)(64756008)(66446008)(66556008)(316002)(66946007)(66476007)(41300700001)(478600001)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiOOCnG6VY5w7Hc7WwMq7KpNdQxrNBAjhAyZDFlSK3B8FPm+42aR31M1JIGn?=
 =?us-ascii?Q?r2S2HLpdwFQ3U3My9PziSL/MPr8A5bELCF+nEM/vDy8VzL+w8hspuixjcnVr?=
 =?us-ascii?Q?yqXN+GPA2I/rTNq9Rz8Iy5P7h3gjkQERGfngcOSOqVMGaOH8Xrc7lvsFyUXk?=
 =?us-ascii?Q?Jl+UT67NAGzA+xaqamQxCezICtyz6Q4S/Qk/UoZSsrCYdp9E7zUcX3HoTO5s?=
 =?us-ascii?Q?Z8YvZAvKfqcSEPcFTkm0r55NVBSCVYTcGwvOeRhRQNU+o2eD4EIInUJeL5mv?=
 =?us-ascii?Q?eh+A2NqX1YQtUNCek0HHHzhPnCaZOEcBQHPOqKBKJLf3ZYBQXKX6Zin2LY0q?=
 =?us-ascii?Q?a5cm5AjyWvAUhNt8TX13VNc7N5H9SP7iOu1YCR86wrJnbiffFdd1sDCtOJm2?=
 =?us-ascii?Q?WcFOTYq6J2rGuxdJHSFTFFh5748bjP6mr0CSNM+qhat3PqX3prLF78bymskk?=
 =?us-ascii?Q?eF/EKtkLcoOmoLtbS0Gn3EOxUNWnAG1Rjr7ftOOpn/ma6zDLxuo/wGFnvg7s?=
 =?us-ascii?Q?Xo3es5xtgzfXQOmD1AKhxbTfSgYqSx16ZrhL6hSD4h0EZvreW0BFI212c50d?=
 =?us-ascii?Q?gOQ6pCilEmdqxm16WWEmH1qOH6YkwMKxAMvfaEdcMRncVE997CgDiODMx22d?=
 =?us-ascii?Q?CcDuzSo1v9rXrxqu6qcsLGLS/EkD1wKFLE1gwgGJvXZFAlphQeryNboE+Yr1?=
 =?us-ascii?Q?gjb6kW2kz3I1EROn2cc+6NfFlWBdBW9CXXtinTnJx6lHX9+nJ46+eEY6dhss?=
 =?us-ascii?Q?30Y+A4mVp2238hsI7ItyCaMMNPS2X8onmu0uwlTIFexTmcrKa7lcoXkPG+4k?=
 =?us-ascii?Q?c3t8N/b2/VMo9zfX4J79HwSh0nTn1dmoCxRGFHS0eP3mZZgGC5jVovu9nHbB?=
 =?us-ascii?Q?XowwQKmbnn4S0LIDU9t2kutH1A9r51LNE5didjLtBL9fLQekRN+LRf0hHzZD?=
 =?us-ascii?Q?rX0qgOMEGHglWfIMr385FUaoGqQYGiBvWw+Jcb5KC66t9LA/ePfy9o2K5pO2?=
 =?us-ascii?Q?Vs5MbT4m/NKwBnyQw+cV0C1PImJjTFjXr6yGmQMTu8yNNaOuyUbh3dUSxaaL?=
 =?us-ascii?Q?UUNjpHkKWW/6w29P7RaCj/iczbntzfnHX9G4vytkIUA8ZdkVvv7ZWrpXMvjh?=
 =?us-ascii?Q?Pecxs7X60s1INP8lZbEBG80TQ2wsOYJ6HlJH/QK596/EYTrBM1cHnQHUlzMA?=
 =?us-ascii?Q?g1xF5OZS2bMZvhvilvd9u8TOSiiOA3syiKCTEafcAcq8S2tdAVuAvQCP70Zh?=
 =?us-ascii?Q?AAA/5mrYoQqZVxlqigj8r4O4kRpDm4bH6hmtmOe5UWLDE2MSJH0EDyqIn84d?=
 =?us-ascii?Q?atFh88lxS2uskBYw1rJn3XGycvp3WLYbXihxCSQtMDDtu7BOilUDP+cbzevm?=
 =?us-ascii?Q?46OI4DcXXXVG4kCJ98BuaVqlF5ujG8ZiWasZvR1kEEwNaLuHOUoqD9y8wvgR?=
 =?us-ascii?Q?LgC1k1eFRUFm1o+UloX+XkleFiI0nTwlEQydc820s3KEpwKnYNMATD0luYue?=
 =?us-ascii?Q?UaKVUBI8fHyUAKQocWdJ1AvnOjKHHyGTiSE/S7bVZtt1zc7i5XU6HJYRIJta?=
 =?us-ascii?Q?LjZxBzmenVYMBHJmqcszmmGIhTvXjrdtA5Pxf+/dvj5snPhdfeu2rZfexomW?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330db9f-bf79-46e2-4470-08dac40e655e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 17:58:53.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRcIjFyab+9GtXf4S5St3yrHMWQd6aky+B6HCgt0SDT9i42Se/UaUIq912bZaH1Pi2RGBJck5SilMz2j4WDTNIljl9pmept7siI6UuCYXvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:27 AM
>=20
> On Fri, Nov 11, 2022 at 04:55:22PM +0000, Michael Kelley (LINUX) wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 8:33=
 AM
> > >
> > > Hi Tianyu
> > >
> > > On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
> > > > If x2apic is not available, hyperv-iommu skips remapping
> > > > irqs. This breaks root partition which always needs irqs
> > > > remapped.
> > > >
> > > > Fix this by allowing irq remapping regardless of x2apic,
> > > > and change hyperv_enable_irq_remapping() to return
> > > > IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> > > >
> > >
> > > Do you remember why it was x2apic only?
> > >
> > > We tested this patch on different VM SKUs and it worked fine. I'm jus=
t
> > > wondering if there would be some subtle breakages that we couldn't
> > > easily test.
> > >
> > > Thanks,
> > > Wei.
> >
> > My recollection is that originally Hyper-V provided the x2apic in the
> > guest only when the number of vCPUs exceeded 255, and that was
> > the only case where IRQ remapping was needed.  The intent was to
> > not disturb the case where # of vCPUs was < 255 and the xapic is used.
> > I don't remember there being any potential for subtle breakages.
>=20
> Thanks for the information.
>=20
> >
> > I think more recent versions of Hyper-V now provide the x2apic
> > in the guest in some cases when # of vCPUs is < 255.
> >
>=20
> On Azure the default for AMD SKUs is still xapic unless the number of
> VCPUs exceeds 2XX (can't remember the exact number -- maybe it is 255).

I don't think Azure has any VM sizes based on AMD processors with more
than 255 vCPUs.  All the >255 vCPUs VM sizes use Intel processors.

FWIW, I have a D2ds_v5 VM (2 CPUs & Intel processor) that shows an
x2apic instead of an xapic.  My memory is vague, but I think that's the
requirements to get an x2apic in a smaller VM:  must be a "v5" series and
must be Intel processor.

Michael

>=20
> Nuno, can you list the tests you've done? They will need to cover Linux
> running as a normal guest on Azure and Hyper-V.
>=20
> Thanks,
> Wei.
>=20
>=20
> > Michael
> >
> > >
> > > > Tested with root and non-root hyperv partitions.
> > > >
> > > > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > > > ---
> > > >  drivers/iommu/Kconfig        | 6 +++---
> > > >  drivers/iommu/hyperv-iommu.c | 7 ++++---
> > > >  2 files changed, 7 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index dc5f7a156ff5..cf7433652db0 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -474,13 +474,13 @@ config QCOM_IOMMU
> > > >  	  Support for IOMMU on certain Qualcomm SoCs.
> > > >
> > > >  config HYPERV_IOMMU
> > > > -	bool "Hyper-V x2APIC IRQ Handling"
> > > > +	bool "Hyper-V IRQ Handling"
> > > >  	depends on HYPERV && X86
> > > >  	select IOMMU_API
> > > >  	default HYPERV
> > > >  	help
> > > > -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> > > > -	  guests to run with x2APIC mode enabled.
> > > > +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> > > > +	  guest and root partitions.
> > > >
> > > >  config VIRTIO_IOMMU
> > > >  	tristate "Virtio IOMMU driver"
> > > > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-io=
mmu.c
> > > > index e190bb8c225c..abd1826a9e63 100644
> > > > --- a/drivers/iommu/hyperv-iommu.c
> > > > +++ b/drivers/iommu/hyperv-iommu.c
> > > > @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(=
void)
> > > >  	const struct irq_domain_ops *ops;
> > > >
> > > >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> > > > -	    x86_init.hyper.msi_ext_dest_id() ||
> > > > -	    !x2apic_supported())
> > > > +	    x86_init.hyper.msi_ext_dest_id())
> > > >  		return -ENODEV;
> > > >
> > > >  	if (hv_root_partition) {
> > > > @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(=
void)
> > > >
> > > >  static int __init hyperv_enable_irq_remapping(void)
> > > >  {
> > > > -	return IRQ_REMAP_X2APIC_MODE;
> > > > +	if (x2apic_supported())
> > > > +		return IRQ_REMAP_X2APIC_MODE;
> > > > +	return IRQ_REMAP_XAPIC_MODE;
> > > >  }
> > > >
> > > >  struct irq_remap_ops hyperv_irq_remap_ops =3D {
> > > > --
> > > > 2.25.1
> > > >

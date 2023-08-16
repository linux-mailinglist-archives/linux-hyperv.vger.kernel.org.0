Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D877D71D
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 02:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbjHPAfu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 20:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjHPAfW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 20:35:22 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E210C3;
        Tue, 15 Aug 2023 17:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe1693uFCS1RzK7IXTW136AABo3QuWC3M45MD2+veD9y9eYNKBJKzM+8UPwnn21EZVnThlfCzdUrrHEPkLESKvwRCdbPb0dQQWrPPn4wYxi2qX93bQt8BZDqv3TS4F2a7HDbLGld708aF6DYN3T9Wmm7SPGvMvQblsIHcYaHc5GfuGM8VGXUsTDKx6mVfPYVviVasl75EszCixPho7Pb+9BrPIyE2W3jLGXaDNW4SI4zjdzVHCztUmmsJGGJ2BncFg7tgWUWOd4ew7QT6grZUltiswQylxaEP6/OGs0o9kqT0UKmhaVgLjZUyAyuuAmhijhvtKObvWYXPNTZ8H/HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ13k5Kzg+MWr9ccbQZihXxCnSGlTdbPVAYlf2To2Y0=;
 b=Iw9h/Fdyva2VgJi2R0LfBOtd7YHwsZ9OJ8Ucmv+DQp6jI67FRd0Vk9IpOuIbFxHzVc0h8h6Stkzmrf0eNTL/QjLdEtJe/be0KCP3vGuuxSsGrMTLsJs8acMvc54v/7IQ1vhR1NiGPCF2jqTMSsENHo3sMBPWXlP1dfC6/Fzd4mb/4Cfcpy/Or9jUS2trCXKSQo7A4cKKeUQmEz0r5b7u7+eUnzrOKsa7sRj6bVbbN5rWL1qRuPUtrTBHzVNhTfdEDV2xyg3im1IrIZDNf0PJEbQyo/dKsKPyznaDCPjOVE78qM4NP6klRjGC++NpalLm1lJduadskpPW+Y0i2XeoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ13k5Kzg+MWr9ccbQZihXxCnSGlTdbPVAYlf2To2Y0=;
 b=dIIwWA9VoLxNrwfTd7mO92hXJve1M6OxEW240vpkcVeIiwmL7i2mQ/k4O37kFCCsdka07eD6OsUCPevuveJVIaTMc3ST7hl3352V98Bfm5BRs20AO8lTnex8yjL+f/Qt0XCd5ns1kcmeDtISgyyOqDfzd6sHkDtyoSfmqj3zJ8g=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3240.namprd21.prod.outlook.com (2603:10b6:208:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Wed, 16 Aug
 2023 00:35:18 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Wed, 16 Aug 2023
 00:35:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during
 hibernation
Thread-Topic: [PATCH] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during
 hibernation
Thread-Index: AQHZzXrpqqhsyu6SnEq5GlDNhSPBZK/sFCqQ
Date:   Wed, 16 Aug 2023 00:35:18 +0000
Message-ID: <BYAPR21MB1688E86B4DB69DB8F3796DDED715A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230813001218.19716-1-decui@microsoft.com>
In-Reply-To: <20230813001218.19716-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6ba78a7-fcb6-4ad8-93e4-b5c3c340b1be;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T00:21:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3240:EE_
x-ms-office365-filtering-correlation-id: a3182620-f86e-42ab-3695-08db9df0aa87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcEixOZvE8iL3zPkH6busO0Pbj1mFUYiOzBVmIR48M8/9vM6QVSJBvs3i/sEn4fK4eXE8+NZmaT7GrMShVFwE05NS++vWm+KS1vYgzxJRN13ELwhumqg20vedris36Zp6FFfJBhO1phcm3itHWM8/vG3fhu7x8PMkT5T3NS0m36zJ3bnxCyoeTNd6Xdjzz/fSHfho13w7e++YK760lINI+dPCNgL4iKqK2KmgmN6Lyc3FDQtpxjZZhdgYSp9xYLS4rOg1ITab3XryRLmk1m0m1mrMITh5z9gSw+nnfmhtw0RNb8M78bmyT1jhW0La4cUbJC1kDSh6uLUWrxtuLg4hC1pghbyL587GEH+F53L+1PEvcBUCzCcPlhqUqD3MaCnAP8sHr8DwoAK7/nZ51ayKdoOkGkKsfLcp6sfToFZ6khAfwXcpt26dg5Cfd21GO7HdiepNUANMZVib9D6iPgT0HIL29ujQY/oCr3VFs96ajBdPShAzUFEJhaF4QJTdUlnpsL6zbXSCLu2lo4xrMJDIorWq7JbpbPNco6HMLAhiIoz/c2A2FZf0lv9XItrt72iiUgI5WdlHIEY+AveRrt5Pel1ePLTOMVesNrqWysVgBDPy97zcYFlTxrDM8AppHz6CzOG5bhKT7vSvARfH/3EuNC72+2fIhcRtBS8a4XSFC5ZczI59Pm+aiauMHYmVVbY90x6TkwwIeUEJdXiL1rRpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(8990500004)(83380400001)(82950400001)(921005)(82960400001)(9686003)(110136005)(86362001)(38070700005)(7696005)(33656002)(71200400001)(478600001)(10290500003)(26005)(55016003)(122000001)(6506007)(38100700002)(66476007)(8676002)(52536014)(66946007)(7416002)(8936002)(66446008)(66556008)(316002)(5660300002)(41300700001)(4326008)(12101799020)(2906002)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Ich3euTFhA87/hrZqm6TDxYR2AcoCVTE1re0/6VLgUQ7YMeVF8OUk6DnQ54?=
 =?us-ascii?Q?XI4+Zc04Tt6JqIxgQdG7jQzyvrJ2E+APYRcbhTl9YgWgSKqmwJLnbM/TCQpN?=
 =?us-ascii?Q?BfDUPOya0x3L41KR+SAVc7tUgO5l7lAKGHXQBYm6NcPoIJewjyNxC0kZGrVk?=
 =?us-ascii?Q?7KQc3KmfUhuCjTdQu6YkxX6puHWfdmuM4PUh0o5IAC1LV6WuEIpt9iRiPRS7?=
 =?us-ascii?Q?cAT9ouazC8tt5A2biAphSKk+ZssnffRyzHjcccpLOlkJKQhmgrRxwS/8h7NP?=
 =?us-ascii?Q?9K1m1OQhSNz+FO2dnVF+RldlyiySKEF0+sYDauk8ED9bTpjhzgja8IyVIKaJ?=
 =?us-ascii?Q?CxpWVdt4l0w9rp+g0sbixQlgkjSuTSUHlTjZMokWae9fObFLkOEI8ZKiYavb?=
 =?us-ascii?Q?NhQN/QXFe3qRq9sDIYBMX6qjXKZTwEP2LYxnjhAlzm6kPhZwtE50HLbwAoMw?=
 =?us-ascii?Q?dc1UYdbGV4XBXaCwojY8BER/KwqU/kKQEE55skK02FBJNjdZLEDHSVHZv98h?=
 =?us-ascii?Q?+FT+Z05IUbVFO40F5b1czq/a1HoiyTtT87kJa7w4SuxH/Gacx3YqlSUuFPj9?=
 =?us-ascii?Q?N/Gx2V6wjJ2pmN8as4CiJ8xDNaIgbvancmlRfzIuGQ0GxdTCb39OYRer11wa?=
 =?us-ascii?Q?sP/a55HzdsB6cOAj2w5jwpL/haanNOOzv6880fgn2PoVXzLBiD/PreMyiphm?=
 =?us-ascii?Q?///RubJDAxRAdrfw+KjlGjvi+l+SL/qgULfmZwY+JNWt3hhTs2q5gIIicXzq?=
 =?us-ascii?Q?arIR4wM+97AEnjuT1aAhf/Nwn7iAr+C79pli/LihcCbVvERhjo4Gz0+ezKfa?=
 =?us-ascii?Q?049FsHbMIigBb7hhDZC7fqB8TEluABnzqQR3kpigfPskmLKhv/k/I1WMfAFu?=
 =?us-ascii?Q?i+JT/RUiBs7Cbq6kQFF/SbOZbemwrpZyaYGErn1B/35fc2J7WouyVQ8z/of/?=
 =?us-ascii?Q?8ncMnxzMzYLqIBGnDoxUp0hkg4WWk/YjQeCYa9Lrhx8//fKtujXELD8FrONr?=
 =?us-ascii?Q?J3AjR9GWLJN1nnpIHUeyhtb33rGf2dEqGPxcZdaMSYewN9puQ9LJJ5GgalVX?=
 =?us-ascii?Q?fVX/Drcqa7MmVvHVKClS+gOuglHqBgN1c+iEOJuoHOOWL9Cs1e7OWPt/7onA?=
 =?us-ascii?Q?/xWrKgPZ1B1xFg/gC/+uEniczQ1bPYIKLVYvf5EGJ7S+UpL5KLRg2Ufgz1Cy?=
 =?us-ascii?Q?EhFmkYaXmp+chf36jer4N0G6ai04jW83jT56+7yAXnTkw/hdYnex0emJGJCH?=
 =?us-ascii?Q?37aFHsk2Q7tgJth88iAQxyOQeX+nTnp8RrPR98yzlCnuNLVlNRpSosYwIO1d?=
 =?us-ascii?Q?BCn6EctlopIbyRJ7ph6iQDWPmCIDmPb/PghYXOVviwjHHvhOA20ZyYaz+uaZ?=
 =?us-ascii?Q?RBU/8j2a2sz7Fm3rXxKN9uc6NeL92CgSuI8wJv5zrPpt3UR/hQ3YGDJeDqna?=
 =?us-ascii?Q?JOCt1rH0zhuDpqcBBQZHhJ4BWdeW7IrKL26bpZE9d5Sr6PljNQIEBh/v+QNT?=
 =?us-ascii?Q?eghMV5txg42cdd7ceow0IqbRr6VAbtQ/6xY7I1mTIpcJIbECzOElxsbgKoSA?=
 =?us-ascii?Q?yIE3giLF97UXwxNEYZ9IiRbvpVf5lUEAeegy2RlGUSt+rkgUw+aYMO7BGrnN?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3182620-f86e-42ab-3695-08db9df0aa87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 00:35:18.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pG8WfVrgtvUKfpyQnF5m05AxNjnY9JmUGDxc03DlS7PLQX/OScNuUCO9k2nlbmnzdV/lPJ9Nd3LyX7i0IyfDkF8LRIOmSLM8xbMJ//+vEUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, August 12, 2023 5:12=
 PM
>=20
> For a Linux VM with a NVIDIA GPU running on Hyper-V, before the GPU drive=
r
> is installed, hibernating the VM will trigger a panic: if the GPU driver
> is not installed and loaded, MSI-X/MSI is not enabled on the device, so
> pdev->dev.msi.data is NULL, and msi_lock_descs(&pdev->dev) causes the
> NULL pointer dereference. Fix this by checking pdev->dev.msi.data.

Is the scenario here a little broader than just the NVIDIA GPU driver?  For
any virtual PCI device that is presented in the guest VM as a VMBus device,
the driver might not be installed.  There could have been some initial
problem getting the driver installed, or it might have been manually
uninstalled later in the life of the VM.  Also the host might have rescinde=
d
the virtual PCI device and added it back later, creating another opportunit=
y
where the driver might not be loaded.  In any case, it seems like we could
have the VMBus aspects of the device setup, but not the driver for the
device.  This suspend/resume code in pci-hyperv.c is all about handling
the VMBus aspects of the device anyway.

Assuming my thinking is correct, is there some Hyper-V/VMBus setting
owned by the pci-hyperv.c driver that would be better to test here than
the low-level dev.msi.data pointer?  The MSI code rework that added
the descriptor lock encapsulates the internals with appropriate accessor
functions, and reaching in to directly test dev.msi.data violates that
encapsulation.

That said, I think this code works as written.  I'm picking at details.

Michael

>=20
> Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 2d93d0c4f10d..fdd01bfb8e10 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *p=
dev,
> void *arg)
>  	struct msi_desc *entry;
>  	int ret =3D 0;
>=20
> +	if (!pdev->dev.msi.data)
> +		return 0;
> +
>  	msi_lock_descs(&pdev->dev);
>  	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_data =3D irq_get_irq_data(entry->irq);
> --
> 2.25.1


Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7072808D6
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 22:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgJAUxP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 16:53:15 -0400
Received: from mail-eopbgr1300105.outbound.protection.outlook.com ([40.107.130.105]:14623
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbgJAUxP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 16:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqg+lz1Bq6AV0EL38wEudqiDcBlKhwVjmXesf6fgIeHfC2ImuzRj/ZjPWn0eTIPMFKghvnSZiEjFOJz0vsIlZSLmemfx64UKMrCq5muGuyV0jHmD6IsKoSq3/TYDiU3/X4nxW5c76q7TBzr2t5xmG5hLFQSIXFcONKI9GE5BoGs4rhe6MktXjFSSJzdF68NVUGSyzMlbTg8gvH69Nfc8h3+aIqq0iYvU0KYAteoDDCJyN9o8F2amfdNHDNlUuQj4V0CHkWDsi3N/8tL/aOtGnmf3xHtZgY9GD0ij4CpWAVB/2agsfYsMMlDw2SEEOB/ofOpjDEJU0stOuu54fJPo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAsDU3KdhS7AGT/L/jTBSxh/tgTn7AcmKpoTyA7p9Cs=;
 b=Nef44jqoq/Xj7NMa77g7WHysHKBZ34tsmMHJQ8KHFc/goWPahohsTuQrt6owbFhq/r3CCuj8Rcc8WDs+MIbu2d4vU9TMKSsN4CHxN7ESSmSYakp1d+bhm+0vhPhzEVHyxTULaEPf/WhC+tKxHFxy1C9bXoR6554pTTP7rkfx3sPwQz6rPGmgkHRxS2nbYKziALmdeEJx6PVM76KLZ6XZwFp9QkjKWJKEyTDDa3j+yNmW8m1RX0mVkIBKaLN+fDbiCe/bWg9C59uLyHE+DPsCdcujYgTQFIHJ5T8Bb5h6rs95aGoE7ngJmVCoo5aP5nQ5Yy7atA70W/hrCk7dWn2RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAsDU3KdhS7AGT/L/jTBSxh/tgTn7AcmKpoTyA7p9Cs=;
 b=Q61KXWDGoPlFIYQarw6QQQy1ei+P0sa46J9VkCsA7DPOgr9U0ca9UDEs7L0B2Z7B3XLeqB9sPDFRSJtPmOJ7jowQfdhpOu+HBLoSClQA8rG9kLUX3LmDw3DkOkQrx8M1xqQXrG0XEo6uQrWQYjGlUF4c+bJ5/dmOSa2NmiAmq5I=
Received: from SG2P153MB0128.APCP153.PROD.OUTLOOK.COM (2603:1096:3:19::17) by
 SG2P153MB0215.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.9; Thu, 1 Oct 2020 20:53:05 +0000
Received: from SG2P153MB0128.APCP153.PROD.OUTLOOK.COM
 ([fe80::19aa:f6a:9e85:17e7]) by SG2P153MB0128.APCP153.PROD.OUTLOOK.COM
 ([fe80::19aa:f6a:9e85:17e7%3]) with mapi id 15.20.3455.013; Thu, 1 Oct 2020
 20:53:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWlYQn2ALom6ybqEW4kSyfVSvz+Kl/Kh1ggANh2ACAAKNvIA==
Date:   Thu, 1 Oct 2020 20:53:04 +0000
Message-ID: <SG2P153MB012888AF8F53861162E18B05BF300@SG2P153MB0128.APCP153.PROD.OUTLOOK.COM>
References: <20200908231759.13336-1-decui@microsoft.com>
 <20200928104309.GA12565@e121166-lin.cambridge.arm.com>
 <KU1P153MB01201EEC711EC37D30687940BF330@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
 <20201001101324.GB5142@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201001101324.GB5142@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1fab85d4-a075-45bc-9e1c-9e38f707c812;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-01T19:58:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:fc2f:eb09:d6c5:a14f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 305110d6-906d-4a8b-72e4-08d8664bfe76
x-ms-traffictypediagnostic: SG2P153MB0215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB02150F4A01826EE47FFC9ACABF300@SG2P153MB0215.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGQ71whVbEidJzmfqphEkZHdeLkAxpPLq3AFMWyYBd/5Mz2bJEA+fxdSxyM1I8vydYADA6GDS81YC9G7HsXRLd5fLHEFPCb6udvsdM81aeLJ7EmyGbVQzouUsYRcct0gdfBtA9SPk8peaCFiC85d3tGZbWzkoBtK6wkr60P9sbvHXbqyn/rFodM+y0XXtDcA3L1t0Vf2SedbO89c7TW4jYPf5sxmKmXk6sqq/N2FU6OQFZjpF3n4qcS9l/DfW1kTqCTsp+s6hQkSoZXZC+CWheQgG9eSZnZvP2q6HZpF0cZBgjzORxnKjT/6QRskyYzj7WbZSCDe+QVexhPG6BshxHFGmelxbWtTezRSvXGzQvI0Sjjh9bt+2Hip7GTindf0JowkCW9AgJVpA5xVmpvJ3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0128.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(33656002)(52536014)(316002)(54906003)(107886003)(8676002)(6506007)(66946007)(66476007)(76116006)(66556008)(7696005)(66446008)(64756008)(83080400001)(82960400001)(86362001)(83380400001)(82950400001)(6916009)(8936002)(10290500003)(186003)(4326008)(2906002)(8990500004)(9686003)(5660300002)(966005)(55016002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YlwQpnnzPrMPlpOvJk0LThA9nqyu045jZZ5SZ/1an/zk52EFm554H8EBHrFDC4NwR5zL0/R/jql1bXhDXuZHSMn9wgu8zXxhwUo8rVEt0UhEuqwA9+I/1KRTLjI0YgpoZ80nlXdEl+9vjrqw5euDunytf87CD8c4tep8dJtoTPx03BQQEn98MKM9li3K7P7t/U2eLKhGPEBnJfelg45T2/68V4g5jwtDMoUe7RLx4BoTfxMhMDF5HxVjXKekgh913+2Tw5LRdrxaASSljWVkwfDjPx1u/ABWp3UGd+mueolGMk9pPITaqWy2OzKhUSOCYVS8uzq/N13iAbpR7VwH9msOM3xCydsGzc67LRu9tB6EBwx/q36J+O2l7pbhSZE92DI+K9ycjoGK16hnbEw8k2M3qLbgfZ/cN3Gs6Vx1g+/qswBcXR4c1w1he2uYBLKOBK6TWZrWyRGw9tyhEINrnUhEascva0QB+85aXTk25P39NlFo9cOh9CXzBq0bE6jSA0hQoOTdKWMgCISRUnr3erTHAbBUjaj8yzMm27w6YJQB838A+IAMBt2eLAF7neG35z6Eq135/JuHmrtMuATRyxtMjp4Dz1ZDvcg8Sdt3guU4T6z0qf2HaaWJ3ItDpfnWSw263NIEIJ8I9nQZFXMPCfwE8uk/bjdkc6sVJGLtN+ijb0+IOO7O4hpuuVh/ixy53vUSceKa0Gzy79ct0UgqkQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0128.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 305110d6-906d-4a8b-72e4-08d8664bfe76
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 20:53:04.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix/877fg5gvAi3KUWZBILIUBdaiMLYNw1iQWBZ8GoPtr6ncvjqjRTbnl6twyszViZ4ePfi+iX/bJlhFF97Lqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0215
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, October 1, 2020 3:13 AM
> > ...
> > I mean this is a Hyper-V specific problem, so IMO we should fix the
> > pci-hyperv driver rather than change the PCI device drivers, which=20
> > work perfectly on a physical machine and on other hypervisors.=20
> > Also it can be difficult or impossible to ask the authors of the=20
> > aforementioned PCI device drivers to destroy and re-create=20
> > MSI/MSI-X across hibernation, especially for the out-of-tree driver(s).
>=20
> Good, so why did you mention PCI drivers in the commit log if they
> are not related to the problem you are fixing ?

I mentioned the names of the PCI device drivers because IMO people
want to know how the issue can reproduce (i.e. which PCI devices
are affected and which are not), so they know how to test this patch.

I'll remove the names of the unaffected PCI device drivers from the=20
commit log, and only keep the name of the Nvidia GPU drivers (which
are so far the only drivers I have identified that are affected, when
Linux VM runs on Hyper-V and hibernates).
=20
> > > Regardless, this commit log does not provide the information that
> > > it should.
> >
> > Hi Lozenzo, I'm happy to add more info. Can you please let me know
> > what extra info I should provide?
>=20
> s/Lozenzo/Lorenzo
Sorry! Will fix the typo.
=20
> The info you describe properly below, namely what the _actual_ problem
> is.

I will send v3 with the below info.
=20
> > Here if hv_irq_unmask does not call pci_msi_unmask_irq(), the
> > desc->masked remains "true", so later after hibernation, the MSI
> > interrupt line always reamins masked, which is incorrect.
> >
> > Here the slient failure of hv_irq_unmask() does not matter since all th=
e
> > non-boot CPUs are being offlined (meaning all the devices have been
> > frozen). Note: the correct affinity info is still updated into the
> > irqdata data structure in migrate_one_irq() -> irq_do_set_affinity() ->
> > hv_set_affinity(), so when the VM resumes, hv_pci_resume() ->
> > hv_pci_restore_msi_state() is able to correctly restore the irqs with
> > the correct affinity.
> >
> > I hope the explanation can help clarify things. I understand this is
> > not as natual as tht case that Linux runs on a physical machine, but
> > due to the unique PCI pass-through implementation of Hyper-V, IMO this
> > is the only viable fix for the problem here. BTW, this patch is only
> > confined to the pci-hyperv driver and I believe it can no cause any
> > regression.
>=20
> Understood, write this in the commit log and I won't nag you any further.

Ok. I treat it as an opportunity to practise and improve my writing :-)
=20
> Side note: this issue is there because the hypcall failure triggers
> an early return from hv_irq_unmask().=20

Yes.

> Is that early return really correct ?=20

Good question. IMO it's incorrect, because hv_irq_unmask() is called=20
when the interrupt is activated for the first time, and when the interrupt'=
s
affinity is being changed. In these cases, we may as well call
pci_msi_unmask_irq() unconditionally, even if the hypercall fails.

BTW, AFAIK, in practice the hypercall only fails in 2 cases:
1. The device is removed when Linux VM has not finished the device's
initialization.
2. In hibernation, the device has been disabled while the generic
hibernation code tries to migrate the interrupt, as I explained.

In the 2 cases, the hypercall returns the same error code
HV_STATUS_INVALID_PARAMETER(0x5).

> Another possibility is just logging the error and let
> hv_irq_unmask() continue and call pci_msi_unmask_irq() in the exit
> path.

This is a good idea. I'll make this change in v3.
=20
> Is there a hypcall return value that you can use to detect fatal vs
> non-fatal (ie hibernation) hypcall failures ?

Unluckily IMO there is not. The spec (v6.0b)'s section 10.5.4 (page 106)
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc=
e/tlfs
does define some return values, but IMO they're not applicable here.

> I was confused by reading the patch since it seemed that you call
> pci_msi_unmask_irq() _only_ while hibernating, which was certainly
> a bug.
>=20
> Thank you for explaining.
>=20
> Lorenzo

Thanks for reviewing! I'll post v3. Looking forward to your new comments!

Thanks,
-- Dexuan

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AFA427197
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbhJHT5G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 15:57:06 -0400
Received: from mail-oln040093003011.outbound.protection.outlook.com ([40.93.3.11]:11842
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhJHT5F (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 15:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPxH6z4qFLNVs7TQzJCJCroVVDH69AG2Qs26BP9/G+QTSjFAYrf6mIQw3Zg5T8lTbfbl7ja/pvGHpyXZkOCj/3BXGg64ZKs/NIlbIXwfHfMd5gW88bwfCV+mMF03KT+6aOezODNBESczvzITAh8tvW+GGhJgsxwNg/6gPompd9Gl3sBOBkUwPASVZ4M6RrIwHriNi3jayy3bEfYQAl82a8Tj6+3wrtvXczP1e8hKtg+wRsCSIMq8NYR1xPhRGkx5+VTQQeRDZlDGkDUa0b85/YblTR6P26hMY+cQW+XnMA1FMEPYhU4kDMOSDEc8wHFjtvxlvMFyhFEtySx9eg2i+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB3bB40g2CL2uQc0iQLmQfsW39KKBZOv9yHJ4hgM+/Q=;
 b=V78BW1+EytcbGEPeCZqXE3OkXctFR0ziLlYxOYlw5SPmAxAVHSfOpCYLhyFNOSOlP+Njuz83FODIfLGJEneEPQv0yJZ+b0csmtfMuHseVYrhjqMJNkazmY/VN8DFGePnoCnfQ3s42ueXSxJX04pr0aMN0t7UvsRllkK6vJSJyzg1zIQOgIIoBy8uu08zzy2/VphYSSv0ncN5cOJ+A5V7kspYJZpQhs/GwvzWfQ7bexCOcjjfKRbPrgDRAN8qOZ3WdWobdQ+Nd20cT8tjxSsZPwODf8lkU7/IuUBK/JCKgt7QrWxtiUgvI9ycSzrRkMQW9dasfPRYD+ltoYJTHYuCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB3bB40g2CL2uQc0iQLmQfsW39KKBZOv9yHJ4hgM+/Q=;
 b=Dkrhp6c5zS/IdutEdx2yac4NoP2b6/k2geQygVl9wudP+gdaBJnbBANNpN6wtTlkNaI3lPZzPSy4Gbb9MhtuNkkoT7xUpVD/GwiXet6vMIBYVHORZHn9RWeoLHwIgGcNR+TSRAPFf0SklCljpqczPI59oAssQpoFLPkpA5xkuBc=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1083.namprd21.prod.outlook.com (2603:10b6:302:a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Fri, 8 Oct
 2021 19:55:00 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 19:55:00 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] PCI: hv: Make the code arch
 neutral
Thread-Index: Ade8Z/d+RNK9WO8BTSODIa+n2Enr/QAERUoAAACoJUA=
Date:   Fri, 8 Oct 2021 19:55:00 +0000
Message-ID: <MW4PR21MB2002FF56AE6443ED2821F555C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
 <20211008191652.GA1364497@bhelgaas>
In-Reply-To: <20211008191652.GA1364497@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe46e52f-494e-4709-a4a0-f33ca3b672bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T19:35:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd4cf865-ffee-43d9-cf96-08d98a958358
x-ms-traffictypediagnostic: MW2PR2101MB1083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10839E9958CF8BE7E4A5BB77C0B29@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4xy62+DgfoJaBVRmxokivJu3dHzdl43lrcDwzlHRkVNbOjN7iG1TK1tf9ufpr3agmcumR11sKI+kXP1qOTxAiMmfPdQXhL3gTyaBZX4RBJNfsJk6FaiDsCLBzujzLb+WxkDmqxjk1hZgky0Z1KUS2EelJ6VmZeVd7k3EiAKiq6FXXh0f8UDC9PnRkX+GO/EknYVpGR8hJHA8U+X2FKr2nYMEnjjibkyg0lfGd8PLjhxBihsJKAl2LOHeCvvXaRUhSmOeJDvdtoq1mqwj7P+Bp3FdnjGdKU0LA55WT+4TFm5e/zz5o8UVgBl+fhfD7dqCJ8kICIqHdf+1/8Mzzjiiw5DYrbmR1vb9ZNkeuqf6L74iyrEsPWXaVdCNEn7cSCFJUUBGoMGP5qFymqHVV5EBG8d2NMdF+yoDflrjbyymfOqcihlhAVNKKO4km+C4HKkKAVkKcRyHUI4MyNlwM08dvumOPracK+X1Lld5XbpkJxX6cDZT+0z/9gQGOj5z3CfyWT3o2wvWbuNurRoCf9yUPVG5JARdP4+LGpJJ0bMWVNIfHZ0HEPrO4aP76uMkNe72ZL+KB816wbi9u/hdX2Rjh2ynw7Bqdqf2OA8e7re67r0tiB1WQqRvW08zsha4J7CMqSU85nWWAXa1cxD5b8/swvF3hd/Vx06U/jJnFn4I9iYCl7yKpxKWek5Ud8Y4Lmr8qOfhRQTMptgCzQMLIRBWhhJc6JQhHX9T8M1Nyiol93XL4TeynnEm07vjWDel7z0zWZg8Qif9Mc2yzpM590fc42KaYlnxi5RdQftpunCZ+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(52536014)(33656002)(38100700002)(122000001)(8990500004)(10290500003)(55016002)(7696005)(8676002)(4326008)(38070700005)(8936002)(71200400001)(7416002)(316002)(6506007)(76116006)(66476007)(508600001)(64756008)(53546011)(966005)(83380400001)(2906002)(66446008)(54906003)(9686003)(66556008)(6916009)(86362001)(66946007)(82950400001)(82960400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HQsNlWgd1tO9M6MFsI8XXvdxazY2PJ6xgt7qjmpLF3Uwl3vi7VL0nbAGyt?=
 =?iso-8859-2?Q?VbGncCqQ8usTpORp6ClIeyH6ZGBaUReG9FI9xzIzZqeQgZZfAW1NDNl/oy?=
 =?iso-8859-2?Q?WMkwXHIU701yRZ1m8J6dwQdIX70DixP3nP1Ho/j+D2pE5OqSbfN6kbNN8u?=
 =?iso-8859-2?Q?aMCyqy+KjQwTFqTkGt31JlqI+eHjo2C7rtlCsY76u6GEJT01c/u7GPXfex?=
 =?iso-8859-2?Q?qOWsFA5t+RkfEmLX4MS+WdJT50y63YQfkjHABJ38gfuGCLEmtFVutp/e68?=
 =?iso-8859-2?Q?KLMZdKuiwHoHDquCUO/qW+8kTUBtHys7lURlcPX3qbJLtU6LyjwXXoDV9k?=
 =?iso-8859-2?Q?uT6fh8Q0m/Gtq7xXlW9eHA21dtCSVE1LNMR5cIcfQNn6/6H2j7+AsEWuae?=
 =?iso-8859-2?Q?rfNQhmqRpEKcApSWFclgUyQp/Oay4Wzr2DNFOFqpVtbREjNRs6EJ9XrQ1f?=
 =?iso-8859-2?Q?QV7eWlAUMi0X/eiMZPf1GWAO7rd7Dj/byi9rJ46h8i1HVhXGlAnHi5FBFI?=
 =?iso-8859-2?Q?aAHtFSFCqsLy5+a2E6PJSymakXLAc/so+0SSMQuN1Kah7gGnDcouVZ9jNY?=
 =?iso-8859-2?Q?YrFzuKTh6c67ziGiorG4/uwb8n5C21O3v6nY6KQHeHvTKtZlsdlSoqJbu7?=
 =?iso-8859-2?Q?tWH3K26Qu7/Iw5QRQTqsp7ieAE8Z7MoKbFspXJTJVXXuDEbwZn4sfLBcgp?=
 =?iso-8859-2?Q?isZazbbfogtZErRSeFRsLwlYP6kzt956ZTY+rF//KFULZfGeXbAaPm9LeV?=
 =?iso-8859-2?Q?zJ4nU9GzbkSuxsaB+a9AzDYilfYa6sbAMXlSuxesCvfFS5BYvWj3cJ/7B/?=
 =?iso-8859-2?Q?ud2hHMqqIb9vif4ZE5yF9aob5UtchHK7mwUM06l9yRV/Tw+qW+i7TX+G5+?=
 =?iso-8859-2?Q?QxTXS5752ky46Fk80unpzx+6NR1QCmJ4PiQa4eJDX3oEdl9W58sXECL3Y1?=
 =?iso-8859-2?Q?M/58k4IYruPc6xFt1onKMhvLqduuz+2N8aYs7edTPUZ6/uSuYwKOCWM1Bo?=
 =?iso-8859-2?Q?vzOoc616zbJBsQLbV+YCLTx87/hJslGqxW2+Isy6Ql64TP4RBtrqZHtH+O?=
 =?iso-8859-2?Q?a9Nl20m7TIOIsWd0EHmYopbtMgLkuONEJmC4Sy6+Tvdwa608nFKpO5JkTt?=
 =?iso-8859-2?Q?x2XVcHvZTthCmSgVDUE8rke52TUeED9/88MgX04Ohtilo3gyKiMPIb/vlf?=
 =?iso-8859-2?Q?daGnTjctRlibIaixCOFQrKazZKjAc5TMmJEwKPeypOlzCiYIDDMsc6vWwK?=
 =?iso-8859-2?Q?p7K4xTF9cMJi48ygXRGKXmRLKTAqYtEJsM0zRAldNXqv6Sr+DckfhTVwaI?=
 =?iso-8859-2?Q?mR5BQk/kovCxMGenVmR6rX29khlkSFNiWsFmORdL2injp/lWAV4rHxRLkM?=
 =?iso-8859-2?Q?oRWShcXimFaA5Xy9+8QwhxBknn9RUGYhzHXhI883UKdFnJtdT0m9NNsAa6?=
 =?iso-8859-2?Q?YkZzHMBWEVNWxrZN?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4cf865-ffee-43d9-cf96-08d98a958358
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 19:55:00.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MdVS1DQTGKcZNJjcEY1/x665fPXZzQ/mxdytpW3ToSvLENTBZsDvLkfmCLr1m0VXBNUCaPW7C8DujUDZ+DbnWz0IMg61+z8hmwmXf6dO4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Friday, October 8, 2021 12:17 PM
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Can you put some specifics in the subject line, please?  If this patch
> does several things, that might be an indication that it should be
> split into several patches.
>=20
Will do in v3. But, this patch only makes the current Hyper-V vPCI code
architectural neutral by adding those interfaces that you mention below.
I will update the wording to make this clear in v3. thanks for the suggesti=
on.

> > This patch makes the Hyper-V vPCI code architectural neutral by
> > introducing an irqchip that takes care of architectural
> > dependencies. This allows for the implementation of Hyper-V vPCI
> > for other architecture such as ARM64.
>=20
> No need to include "This patch"; we already know we're talking about
> this patch.
>=20
> Write in "imperative mood", e.g., "Encapsulate arch dependencies in
> X ..." instead of "This patch makes the code ...".  See
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fchris=
.be
> ams.io%2Fposts%2Fgit-
> commit%2F&amp;data=3D04%7C01%7Csunilmut%40microsoft.com%7Cb40962bf1
> 5614957781608d98a9030c8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C
> 0%7C637693174187863024%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
> ta=3DXlrM%2Bzg92v%2BXxXObWQbznaB%2F6ZW6u79NtDoG4FfyhXw%3D&amp;r
> eserved=3D0
>=20
> Wrap the text to fill 75 columns.
>=20
All of the above points noted; thanks. Will address in v3.

> You said this "introduces an irqchip", but I don't see a new
> struct irq_chip or similar.
>=20
> The important part about making this arch-neutral seems to be adding
> these interfaces that will encapsulate arch dependencies:
>=20
>   hv_pci_irqchip_init()
>   hv_pci_irqchip_free()
>   hv_msi_get_int_vector()
>   hv_set_msi_entry_from_desc()
>   hv_msi_prepare()
>=20
Yes, the wording of 'irqchip' is a bit misleading for this patch as it gets
added in 2/2. Thanks for the suggestion; I will reword in v3.

> I'm not sure wrapping them in "#ifdef CONFIG_X86_64" is the best
> approach, but the IRQ folks will know better.
>=20
Hyper-V vPCI is not firmware enumerated and so we cannot take a
dependency on the firmware to dictate whether or not to instantiate
an irqchip or not. I am open to suggestions though.

> > +++ b/drivers/pci/controller/pci-hyperv-irqchip.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
>=20
> Spurious blank line (follow style of nearby files).
>=20
Noted, thanks. Will fix in v3.

> > +/*
> > + * Hyper-V vPCI irqchip.
>=20
> > +++ b/drivers/pci/controller/pci-hyperv-irqchip.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
>=20
> Spurious blank line (follow style of nearby files).
>=20
Noted, thanks. Will fix in v3.

- Sunil

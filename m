Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268F28BBB2
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfHMOjY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 10:39:24 -0400
Received: from mail-eopbgr760130.outbound.protection.outlook.com ([40.107.76.130]:22980
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbfHMOjY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 10:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXcagD8OLZmFXtyzJtb5jEC6AxsxewX1CKynxvyt90oxMeCXWoD2qpJpjB7bljy4VO0OVXHUyGQGbaty1JCHlncFk4BXhttPfs6F2flQTgX8v/BhM9JnZaDQy8J3rzkHcPKsXatue1zp/1sl036aj6Icaxjpu0GA6hmpSkwBhrPXV/KRhKtfG5vbw2q+kPIlpDh7LILG/aVso4fPIRyEBvbcDej2o2dkaz4WQq+8X/laHiITk5B2QkzrTfDWpo7EbTLZ58nBJuhqcS9bc4RUXwVXWh0dCYmfMJ6HMSv8DxWR2hMnAgpd4LYkXe8f5N6FP1hmmyTW39rp0ugmNWoCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W60JursFaeMsc1iXAcxrhkADctBuZBxoDb+Y98lo4fo=;
 b=CYI+ynYOBW/n3fyHO2L11L4MJy1zP9+ocqAJNcO4VxdW9D9l2dtieucLxOWMQ255FxrZY5T8tTIh3SGRzyoIWmUjhrk9JhJ/LrpmWKaa5BKhKV5KuVpfgjGSTRTHRa//3yXbXlb7qFE+vAJfz+GQh28pkOChRkDFmYu47ZnYixb2YuSxYwCexDOaoc7H8KWR2ybRg4Lk3vq5/eq/Sdq6Tn314yi3CSg3qQdV4Kqhin8HWEzvqcQpXxuG0DoI2NH/pYfiFZjWGtVGumOUrmQhqKniYExkHwdFsfhleO0R4Lw+g+aJdOi8sUaTeMDh6/OsA5+JqdwuskmRJxEQY0YOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W60JursFaeMsc1iXAcxrhkADctBuZBxoDb+Y98lo4fo=;
 b=X45sc2zj6843NpAt5IStRhWfgpWh3YTUzez7iKDUqLmJ0vDAkBS6JT9qaxg1GUO5tn4FUiFjVrMx7f3Xbng1pubP/1eoU56sO0VDwVNykiNvCL7WPwGR/wrFcIYJ43eGfOVfdhVnGMlDcwO2p3zT8uqPLv8/t3nGJwTUUuTExrw=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1515.namprd21.prod.outlook.com (20.180.23.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Tue, 13 Aug 2019 14:39:21 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d%6]) with mapi id 15.20.2178.006; Tue, 13 Aug 2019
 14:39:21 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVUTqte27Lajt/EEyKPTfwyVUoz6b43UWAgAAqP0CAABv9AIAAA3HQ
Date:   Tue, 13 Aug 2019 14:39:20 +0000
Message-ID: <DM6PR21MB133744665D87C5B8FC9127E1CAD20@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565634013-19404-1-git-send-email-haiyangz@microsoft.com>
 <20190813101417.GA14977@e121166-lin.cambridge.arm.com>
 <DM6PR21MB1337D4F34CAA49BE369FB793CAD20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190813142540.GA5070@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190813142540.GA5070@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-13T14:39:19.3206366Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59d6fc14-db84-40e0-94d5-6148b1ab89cf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec6678e5-ec50-44a7-a826-08d71ffc0740
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1515;
x-ms-traffictypediagnostic: DM6PR21MB1515:|DM6PR21MB1515:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1515778DF881E901D72B58D3CAD20@DM6PR21MB1515.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(13464003)(81156014)(10090500001)(478600001)(7696005)(10290500003)(8936002)(81166006)(8676002)(76176011)(71200400001)(71190400001)(6436002)(86362001)(446003)(33656002)(305945005)(6506007)(186003)(53546011)(102836004)(14454004)(7736002)(9686003)(26005)(74316002)(55016002)(6116002)(3846002)(2906002)(52536014)(66446008)(64756008)(6916009)(66556008)(66476007)(229853002)(66066001)(8990500004)(5660300002)(11346002)(76116006)(66946007)(22452003)(316002)(256004)(14444005)(476003)(486006)(6246003)(53936002)(4326008)(25786009)(99286004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1515;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MRzl2uVFdMlp+0loecV38TKmFHwtoWzzV2u0dQJIgcgd0J2jA5H6ka82ZznGw5xKrQ84kBmhBFRC7riFQ9NUekAdzz1kqOOJPca/6wHEfxqX2GkfRsSg3ZQkisPplf9hlgM68W8nmiNhWRALyKz8EkVEzgQk5AODXnNM2TP18Bkdfli/Jyv7I2ztDCyOTondhZEXFrACrcbsnm4IN8gmVV5G7TOAeboaOrpH5K5ORU8veb6i5628MSzX89ZcfTA1yOWOKnIr4ehuPoVcEQRw8p/ttlFUISbb/UJXbKO/5ztNi8vweAo8O7iZE+UQK+wMtwTRvcRThmYgcSoJ8hl0m3oG1mJ7kvir8M/heutRjSxbDWDBKi4PwD9+XZQrr39pFnCXkStZkX5uVl9qWPOGO44V95uvH4WR72hvXBlZvRU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6678e5-ec50-44a7-a826-08d71ffc0740
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:39:20.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3J63wTr0nN5lv6vNKf22itxg+FtaGYWQF47QxMgdWmoOH7D6OCRqkja8Yn+xy5o4HKoJ15TIMg7hx+6itFX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1515
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, August 13, 2019 10:26 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
> collision
>=20
> On Tue, Aug 13, 2019 at 12:55:59PM +0000, Haiyang Zhang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Tuesday, August 13, 2019 6:14 AM
> > > To: Haiyang Zhang <haiyangz@microsoft.com>
> > > Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> > > <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > > olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain
> number
> > > collision
> > >
> > > On Mon, Aug 12, 2019 at 06:20:53PM +0000, Haiyang Zhang wrote:
> > > > Currently in Azure cloud, for passthrough devices including GPU, th=
e
> host
> > > > sets the device instance ID's bytes 8 - 15 to a value derived from =
the
> host
> > > > HWID, which is the same on all devices in a VM. So, the device inst=
ance
> > > > ID's bytes 8 and 9 provided by the host are no longer unique. This =
can
> > > > cause device passthrough to VMs to fail because the bytes 8 and 9 a=
re
> used
> > > > as PCI domain number. Collision of domain numbers will cause the
> second
> > > > device with the same domain number fail to load.
> > > >
> > > > As recommended by Azure host team, the bytes 4, 5 have more
> uniqueness
> > > > (info entropy) than bytes 8, 9. So now we use bytes 4, 5 as the PCI
> domain
> > > > numbers. On older hosts, bytes 4, 5 can also be used -- no backward
> > > > compatibility issues here. The chance of collision is greatly reduc=
ed. In
> > > > the rare cases of collision, we will detect and find another number=
 that
> is
> > > > not in use.
> > >
> > > I have not explained what I meant correctly. This patch fixes an
> > > issue and the "find another number" fallback can be also applied
> > > to the current kernel without changing the bytes you use for
> > > domain numbers.
> > >
> > > This patch would leave old kernels susceptible to breakage.
> > >
> > > Again, I have no Azure knowledge but it seems better to me to
> > > add a fallback "find another number" allocation on top of mainline
> > > and send it to stable kernels. Then we can add another patch to
> > > change the bytes you use to reduce the number of collision.
> > >
> > > Please let me know what you think, thanks.
> >
> > Thanks for your clarification.
> > Actually, I hope the stable kernel will be patched to use bytes 4,5 too=
,
> > because host provided numbers are persistent across reboots, we like
> > to use them if possible.
> >
> > I think we can either --
> > 1) Apply this patch for mainline and stable kernels as well.
> > 2) Or, break this patch into two patches, and apply both of them for
> > Mainline and stable kernels.
>=20
> (2) since one patch is a fix and the other one an (optional - however
> important it is) change.
>=20
> This way if the optional change needs reverting we still have a working
> kernel.
>=20
> In the end it is up to you - I am just expressing what I think is the
> most sensible way forward.

Sure, I agree with you, and will break the patch into two, and resubmit.

Thanks,
- Haiyang

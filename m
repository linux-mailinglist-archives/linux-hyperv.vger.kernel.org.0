Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9488A2B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Aug 2019 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHLP4I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Aug 2019 11:56:08 -0400
Received: from mail-eopbgr700136.outbound.protection.outlook.com ([40.107.70.136]:39393
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfHLP4H (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Aug 2019 11:56:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioTVZ8tUxzNWpOIdfm/mXTSJb1bn0qOyqLPyu/0+oKh3OyYXSehhcV5Cm4b7valUtYhH9TbWYGuwoREusz13nDrZATI6msRDFvGqeP47cf4YcDm0i77qkKsa+DcqCl6tDf2gZOtDmm8U+yTvV2yzez6ID3hTJ0GYkyEowHswBt8xV0usgUmOYrzTA7o9W2UQz08l00rPygyv61hh19RyL3RtBm8NQKeVnWg/bMg8+bUdW0+8uQvqPUd/rwlvQDWVLHWnefuPT0AazSfNykn6/cRR4seNs06tnnM28KQvVVK9HrbISL9daFaJSkZdTGmkEyasd9rExOoOt4lXCiE26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB27NeJ5tG+cRlrAkYIf07bbwnSrdLlZ7zPXg6xmvKw=;
 b=E3FIexV6IL+aJN8lUSQrJ//+n75wyRTZYxT17X4e9Fo4rBtZ55e15AwV8aQ7VaWm+h0CjwMnH25N151hGma0ABzL7MkqPcKtLa++j1Yqub/Nkdzm+vy/nuyMiH+JWqxhrhDS3WRqAKVGyh4u1Uq9Dk5NmIWKIQi9yFyVF7wIHbGIrhuA/vnRO7vQa/aLd6m7ILDI0aruIgfqRxO4G4Op053chQV8M9zms4vfmM/ivvfM6u7vtkpfCR60muzGhsSUNWe1Vj9SZziMVt9IcUHgQhy7atpruMnpyJMLK8oZ9i2VaVwcqDXjegtv9bCpLodb4KHXCd7mnW/WGDSVLc8iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB27NeJ5tG+cRlrAkYIf07bbwnSrdLlZ7zPXg6xmvKw=;
 b=ijCC3jwmFZh78iz8lGQVbGrcUsIDJyg5e2HhyZmpLqhxbG1vdnd/+A7uFZ38ym7VsIUqSq0fPG26mmCoCH97dSF19lJ79Jhl2qbwuzDuiOv7HJWVUKp7nhQPxsnC5ZomwnE+KfF3QxtNfzFkyIC+ZCRNXUCRIPpTG+6aLASx3Vw=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1338.namprd21.prod.outlook.com (20.179.53.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.6; Mon, 12 Aug 2019 15:56:05 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d%6]) with mapi id 15.20.2178.006; Mon, 12 Aug 2019
 15:56:05 +0000
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
Subject: RE: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVTLH3GagQ2bG1NUyV/+P043l1Z6b3rpuAgAABZXA=
Date:   Mon, 12 Aug 2019 15:56:05 +0000
Message-ID: <DM6PR21MB1337424D893B60F48F45A289CAD30@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
 <20190812153833.GA30794@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190812153833.GA30794@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-12T15:56:03.3755135Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b79b9147-92f9-4119-8236-67be47ff75cc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1247fec9-e6e6-46a9-f0b2-08d71f3d952f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1338;
x-ms-traffictypediagnostic: DM6PR21MB1338:|DM6PR21MB1338:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB133863259570AE5236FBA976CAD30@DM6PR21MB1338.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(13464003)(199004)(189003)(26005)(256004)(14454004)(229853002)(4326008)(66066001)(10090500001)(54906003)(52536014)(53936002)(6116002)(9686003)(6436002)(3846002)(2906002)(66476007)(66446008)(66556008)(55016002)(64756008)(66946007)(6246003)(76176011)(33656002)(14444005)(6916009)(305945005)(7736002)(76116006)(478600001)(316002)(71200400001)(186003)(7696005)(71190400001)(22452003)(8936002)(81156014)(74316002)(8676002)(99286004)(476003)(25786009)(81166006)(8990500004)(86362001)(11346002)(6506007)(53546011)(5660300002)(446003)(102836004)(10290500003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1338;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s4XFq481U9xZ3J+7mpUj83smK+y9cxmROjCoo1Ta2DDoWA3zmj0Hv7HssgzWu1hPlr3BDuPjYdKSvVpKnaTVDGonkOu3EKuPXSlltdwVL7TbvqprpvkZSn+NcmqnA9QUMzR1e8df9HHejnUOXJ7C8DswJjvUs7rozvFpKiKlip29dpROwSCQiyAvnp/bBdCXv5LEtKWofIQERzBRCKGbWHTRTC8jbb5CNwCyhri2yeDrx8Zdko3NPiSmHxAeW1LOqYJhRpi4ZKaUfQJIvejRcGEZ76eQdEqvUaaY7Gi8ZgxAEW9q7CUklkuLyHqrKwgPuTHsoTDp7yBX3M35be6Avq96VFPNRKOL+OHJ5OqeM+GYy3/bXgKCFF0sydFDEl+GFY5EQasM0e+eqdAu7dy29InsOAgKs2ElJDnuovybE3c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1247fec9-e6e6-46a9-f0b2-08d71f3d952f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 15:56:05.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOo6anCblGEw8zO/UlBEin47AlovXZnGwZs2zIkQUCDS0E2Km+8hrok5MEdXtisQN1cTv7UTUoxkbQyuQIcOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1338
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, August 12, 2019 11:39 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
> collision
>=20
> On Tue, Aug 06, 2019 at 11:52:11PM +0000, Haiyang Zhang wrote:
> > Currently in Azure cloud, for passthrough devices including GPU, the
> > host sets the device instance ID's bytes 8 - 15 to a value derived from
> > the host HWID, which is the same on all devices in a VM. So, the device
> > instance ID's bytes 8 and 9 provided by the host are no longer unique.
> >
> > This can cause device passthrough to VMs to fail because the bytes 8 an=
d
> > 9 is used as PCI domain number. So, as recommended by Azure host team,
> > we now use the bytes 4 and 5 which usually contain unique numbers as PC=
I
> > domain. The chance of collision is greatly reduced. In the rare cases o=
f
> > collision, we will detect and find another number that is not in use.
>=20
> This is not clear at all. Why "finding another number" is fine with
> this patch while it is not with current kernel code ? Also does this
> have backward compatibility issues ?
The bytes 4, 5 have more uniqueness (info entropy) than bytes 8, 9, so we u=
se
bytes 4, 5. On older hosts, bytes 4, 5 can also be used -- so it has no bac=
kward
compatibility issues.
=20
> I do not understand if a collision is a problem or not from the
> log above.
Collision will cause the second device with the same domain number fails to=
 load.
I will include these info into the patch description.

>=20
> > Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this
> idea.
>=20
> Add it as Suggested-by: tag.
I will add this line.

Thanks,
- Haiyang

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F58D73D
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHNPdQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 11:33:16 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com ([40.107.80.135]:35657
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfHNPdQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 11:33:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmE/kzzYaUI02dx5ODiectrkjlF/5fid527XrphHb6PC4dvp43SVGboj2+Qs3SW4AL+KVqdf7YGwo2vyRgVLHNa94J4K1DREwyee4bOa0fQ0luXtYdXZdnp7c2kCWXHglfwvEkAMLVggabRGX88FYkrBYEN8xQHZ+TexErS4h7Ey/7Fs+LV37aOotlFgw4DVcShzrYQ3qRZ9thj+EsM0lcVQlHxlBiXEqQzW2TmWgTS53c639peVApVJH1kBUG+6Idmb+mxipm3r9mu9nmo8aJT0djD78xnN4h8xSkkK1ob7wHvJS9vhIk6iAIy8tYKoHlU7zNntSCXr43l9aZNIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIhTOy2cuOIX2kHNoItxXfeaYTyKydVXhyGXAaEwkmc=;
 b=npEqYD5A2bcZs/eUexWc6JAMJ8+6aCNn9//0sP/FfZyYJuk+9yS1hmBfbRi4y+Dr+2bqKJ54Ol/uhUIHUUnwU7ufWp+DDTd82nchU0Ut2WFQXGmC2V0KsPOKLuxeFnuqSQ7FXSmsgGOVBrVXueAhBU5bJixj29uDxMDHBWBrsPmZYmYLluZ5uQQJRsbNBb79n1nTbgpr5ULE+SkiiuIkEDv8dB+DihajQka+3+kBm40ludQ5RFeHdw0PgEUPJ0K8uQO58PMFpFCQLhOTLWVe3aAddMRM222nntNMPj8GWvhY8QOvDh9tIuZxur281eu/x7h3jCIvukmO5a5lF5+++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIhTOy2cuOIX2kHNoItxXfeaYTyKydVXhyGXAaEwkmc=;
 b=hSientgCm3JxkGMbTM3X9gkYi+gE5/3z8e7N1XddC699yL0NHupx1Mx3xyTJjlf5eW/NGUrN2lAlRv0HsO7GQ2TiQHW3dQxxYaNwDaPCqy9Nz6FTIwe93gfVgY86Te2XQ1tWGAsMPHi18sDsgXHIgL24aaGAxwdww+zNGukmx3M=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1451.namprd21.prod.outlook.com (20.180.23.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Wed, 14 Aug 2019 15:32:34 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d%6]) with mapi id 15.20.2178.006; Wed, 14 Aug 2019
 15:32:34 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVUjimvM3UBIvJXEiYaEn5NujA56b6DqwAgAC1WWA=
Date:   Wed, 14 Aug 2019 15:32:34 +0000
Message-ID: <DM6PR21MB133729FAFEBF5588F07C6F1ECAAD0@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
 <20190814043428.GC206171@google.com>
In-Reply-To: <20190814043428.GC206171@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-14T15:32:32.3665756Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b78d3f55-dc9e-4578-9b76-462eae9ee97a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87838a0e-b350-4d7f-0f69-08d720cca0e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1451;
x-ms-traffictypediagnostic: DM6PR21MB1451:|DM6PR21MB1451:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1451729E9A1BA786E4408522CAAD0@DM6PR21MB1451.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(13464003)(51444003)(189003)(199004)(76116006)(66946007)(64756008)(66446008)(229853002)(76176011)(66476007)(66556008)(10290500003)(54906003)(81156014)(81166006)(6436002)(55016002)(8676002)(9686003)(10090500001)(8990500004)(5660300002)(7696005)(8936002)(99286004)(486006)(6246003)(22452003)(11346002)(4326008)(476003)(25786009)(316002)(53936002)(74316002)(446003)(186003)(14454004)(66066001)(33656002)(478600001)(102836004)(53546011)(6506007)(14444005)(2906002)(26005)(86362001)(7736002)(305945005)(52536014)(6116002)(3846002)(256004)(71190400001)(6916009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1451;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ESsc+VxkU28p8DVtivOQBtOsn0KdklLLHGGItZ+Y7NGiHuR9p/Yr3pNj1yqaHdyO/VZBdZvxwLYMS9nTsor9XZpzLnbGfUaAW53Gg7accdyHtd9+/u8472A9T/SM6ckV1DyTTv8xQW3eFKLZOxe7iduYSR4FQ7F1oHmjbCw2ngL8oLy34gNRSfgI2kr8O+AjM2txFiG4Pli1H8Uai5SUUbUtDzqe7dTQb1n2whv/Z2aBWkd44s3b41MIk4r/IW+067QcYXfCkI8cW/b3eC0474wozU3eMDCH9FRf4YmyIkGjTrKSRN1n4oiOIAbFClYH8Guw6PDJ0ibuIUF7hwNxGcDOQGjIpzvfhTYvtY+55rpCb19G0xJXOAxyHO9mDL+2kcJYAgynFG/B3eWpqDvqrQNKZgEDNtWRWj43s2vwXxU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87838a0e-b350-4d7f-0f69-08d720cca0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 15:32:34.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZ93NglMh/A/P7kl7lvCH3pecYHfHZ6PZeUf2QbkR60+A6tkXjgsOcZBQB9ID3Ux2mNLF7jD/zixiY86P6lZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1451
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, August 14, 2019 12:34 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; lorenzo.pieralisi@arm.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain
> number collision
>=20
> Thanks for splitting these; I think that makes more sense.
>=20
> On Wed, Aug 14, 2019 at 12:38:54AM +0000, Haiyang Zhang wrote:
> > Currently in Azure cloud, for passthrough devices including GPU, the ho=
st
> > sets the device instance ID's bytes 8 - 15 to a value derived from the =
host
> > HWID, which is the same on all devices in a VM. So, the device instance
> > ID's bytes 8 and 9 provided by the host are no longer unique. This can
> > cause device passthrough to VMs to fail because the bytes 8 and 9 are u=
sed
> > as PCI domain number. Collision of domain numbers will cause the second
> > device with the same domain number fail to load.
>=20
> I think this patch is fine.  I could be misunderstanding the commit
> log, but when you say "the ID bytes 8 and 9 are *no longer* unique",
> that suggests that they *used* to be unique but stopped being unique
> at some point, which of course raises the question of *when* they
> became non-unique.
>=20
> The specific information about that point would be useful to have in
> the commit log, e.g., is this related to a specific version of Azure,
> a configuration change, etc?
The host side change happened last year, rolled out to all azure hosts.
I will put "all current azure hosts" in the commit log.

> Does this problem affect GPUs more than other passthrough devices?  If
> all passthrough devices are affected, why mention GPUs in particular?
> I can't tell whether that information is relevant or superfluous.

We found this issue initially on multiple passthrough GPUs, I mentioned thi=
s
just as an example. I will remove this word, because any PCI devices may
be affected.

Thanks,
- Haiyang

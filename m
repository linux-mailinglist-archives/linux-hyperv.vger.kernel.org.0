Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC48B93A
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHMM4E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 08:56:04 -0400
Received: from mail-eopbgr730102.outbound.protection.outlook.com ([40.107.73.102]:31442
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbfHMM4E (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 08:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am+c/gGP2fulvVgpcNsvWqovEhV+aylpN8tMMvOm4y8xXC9bgga4uuJ7s4/XF59lUObJ7s+jqw855D2DfIlD+QxsfbyVtMac4IfyXLY/6R6RBUPbJXGm7XXvqFFDJKVFCcPsIH36g9Nxq4qmsTz9ctXLAmitji0AeDixYL17K6zRgXnMycctxAXuci9ZaTf3qlzSYyQ/MRGL/vmE9BiMFbNarXe8Z6tijhJZpYUci4Gnwbx2C8cFi/iUlG5oHdoaNq6zZHh01B4txXl3rIxks7xrGiXJQiXETuJpCfFj9bHETIMU8YI8NC2RPKux6d2IzBS5yPvNjkgLMCHfGSEePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIk0+13FJj+qtW5UGblWzQexpt38toni0ecJfqUfnyE=;
 b=hQ+OapxZQbGqVnq52Qm+uH6Z1JmHC+VbEJhonceoTdCcTl0v/NTSE4cn7wo0PHhSEFWH5GvwaqsHEfDaLIE3MCSDEYOq8yNbrhsw4k8yUCvDGCYjhbVWzELFVdcgGj5f5GwHZ4FprlbpljcCYofDUCf1T5WfFzAMueK24N25lIzzFHR5pzuyKhYezbwhu2HxaATf7MEwmhYl/ltkQ254eTZhm0uDQwtxf7sOYHTLtW2gMTSP53hxZWsRk0knig67ebQQBrEsDTNSu6wYCILlq4Wiqex7pj2fekkLXMik72REJTE5HoQNKp/WOddRU3GRHhMKmof4IjbrNnRpD5fLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIk0+13FJj+qtW5UGblWzQexpt38toni0ecJfqUfnyE=;
 b=hOaQ4PJWayGz5Li/5yIbvyHBx954cR5JkrD/1AaJLwRsFwru4AEobyeTswcR61tsdG6s92x+wNhTD4LxkSE3W3Xyh7GuV55U6D9vpyZ8afjsBrAbtIhUFy0YYY2v6H/aKE82NdvwSagdoOAhdKzG+JwE5zntFe8d69dRPtvevo0=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1355.namprd21.prod.outlook.com (20.179.53.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.10; Tue, 13 Aug 2019 12:56:00 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d%6]) with mapi id 15.20.2178.006; Tue, 13 Aug 2019
 12:56:00 +0000
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
Thread-Index: AQHVUTqte27Lajt/EEyKPTfwyVUoz6b43UWAgAAqP0A=
Date:   Tue, 13 Aug 2019 12:55:59 +0000
Message-ID: <DM6PR21MB1337D4F34CAA49BE369FB793CAD20@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565634013-19404-1-git-send-email-haiyangz@microsoft.com>
 <20190813101417.GA14977@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190813101417.GA14977@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-13T12:55:58.1733042Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aac06c14-720d-4d87-ab8a-42247b19e931;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b7ce7f3-357c-4c35-6de7-08d71fed972b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1355;
x-ms-traffictypediagnostic: DM6PR21MB1355:|DM6PR21MB1355:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1355DB8D3BDDD5394C37922DCAD20@DM6PR21MB1355.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(13464003)(10090500001)(478600001)(74316002)(53546011)(8990500004)(102836004)(81166006)(5660300002)(305945005)(81156014)(2906002)(6916009)(8936002)(66066001)(316002)(7736002)(6116002)(53936002)(33656002)(4326008)(3846002)(6246003)(22452003)(99286004)(54906003)(229853002)(6436002)(446003)(26005)(7696005)(25786009)(76176011)(6506007)(14454004)(9686003)(71190400001)(11346002)(8676002)(186003)(10290500003)(64756008)(66946007)(14444005)(52536014)(66476007)(66556008)(71200400001)(86362001)(476003)(66446008)(76116006)(256004)(55016002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1355;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EKSJjfBT2J8vJwx1uk1mxj/EvLioj1rUcF0CXiCGKOgVRbVOyp6uAyyyM1g/4lszxBaV4lgC4Js8377/FD5BtzXzsjhd9QAYKgI7iodwSZ3oU9xh3lUafqT1Z158iHKoYVpsSZanUweO4YOx3bxG5nyurDLorJnWNu0BuCK86qZhFzgB2La4JMXFa6jRkHXLciM6OR0c9HBUwVADeQfaxY9xzRyRLFPFwlv5XD4Wziuej0WQQIUERPpN9MYphJi8pomg/zIGa6PIm3hRRnpPr1xyVe3fwXkxanCOzyb8YIIDI3pHBY9p/oi75Qh0WuAUlxuav2kVECXMP4ybeVVM20YGdk9hMjN08daS2FDQ9QbK4DVmcW90C4pjMuW0nUUX+AXBuxIdU5cEEyZT4JjKXTQcUdUIbx+Y4wEiKU2qwkU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ce7f3-357c-4c35-6de7-08d71fed972b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 12:55:59.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SO6jj6BsEbs8uw2EkHkpGQAZ26tu9PyyARzEYf0KW9d0/pimtunNrDr7ZItpG/ouTC325H54PfxBFaJspZPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1355
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, August 13, 2019 6:14 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
> collision
>=20
> On Mon, Aug 12, 2019 at 06:20:53PM +0000, Haiyang Zhang wrote:
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
> >
> > As recommended by Azure host team, the bytes 4, 5 have more uniqueness
> > (info entropy) than bytes 8, 9. So now we use bytes 4, 5 as the PCI dom=
ain
> > numbers. On older hosts, bytes 4, 5 can also be used -- no backward
> > compatibility issues here. The chance of collision is greatly reduced. =
In
> > the rare cases of collision, we will detect and find another number tha=
t is
> > not in use.
>=20
> I have not explained what I meant correctly. This patch fixes an
> issue and the "find another number" fallback can be also applied
> to the current kernel without changing the bytes you use for
> domain numbers.
>=20
> This patch would leave old kernels susceptible to breakage.
>=20
> Again, I have no Azure knowledge but it seems better to me to
> add a fallback "find another number" allocation on top of mainline
> and send it to stable kernels. Then we can add another patch to
> change the bytes you use to reduce the number of collision.
>=20
> Please let me know what you think, thanks.

Thanks for your clarification.
Actually, I hope the stable kernel will be patched to use bytes 4,5 too,
because host provided numbers are persistent across reboots, we like
to use them if possible.

I think we can either --
1) Apply this patch for mainline and stable kernels as well.
2) Or, break this patch into two patches, and apply both of them for=20
Mainline and stable kernels.

Which way do you prefer?

Thanks,
- Haiyang


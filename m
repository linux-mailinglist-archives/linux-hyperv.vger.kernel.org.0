Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F99FD60
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2019 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1IpU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 04:45:20 -0400
Received: from mail-eopbgr1320122.outbound.protection.outlook.com ([40.107.132.122]:64096
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfH1IpU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 04:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTb6stk3X4DFfo9UJ7121oqn142FoaLUQKr+5HbglGzidLrH4kSC+9K7ertZXuGpCqwSjmpC7JH09Dk1YO1yB4Jf0quZmcgAdhnEr3x6xs0Gk6rLs/ccAGUOhJZdjfQJRe2MD2Zy03mNQ4izLzQcW0RMD0KjfQOuXCQs42HPMGqnB1pt7rXNwvXTEu7vLq5JBUn3usjx9XydR8sMQyGzEhqqgUwmrdfJHNN0uhAS1UZPqgBDg8zt0FtBPEQkcviGmRR37+5b5RHmlcU8L8dTHMF+9PuTh6GWjPlcZll2nuqxtYsTH7BnGSnfbvSVuvbTNQqOUvNAmxzqs1//1b1nJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mpp4gY0hdl3enDz7UuGaAhzM9ufS5hhjJ0x9zT22R8=;
 b=Qz3pqgIjzg32r8yH4W4t3bja332jfJ7eDI/d+BQGXTcBLa/D+z898Zrxvpq/+9LemE/Da/hMise+VFlPxGG5EtHoXdUxuij/rd/XnOmWEMV6gcBYUtWyyUM5RkafKG45aCZo031KZJnd4Pr76BReZ07mc14rcZteea+wwl9AEx2CCR8MGojfURQsBNHmAtq8Rrx98ZpSJBCYyuF2GfpgBAn54lwrXlXUBZCZ1iXFgRrBcRAeEM3FW100JIsU5HGXA1bsBnnsmGGMlbBlf7yFkaZ1vPl3UL9iRAA6PsITyGf3RPrRhB40P6K0WuxhvaZCpEEmamYOw5GtUByWhF4E3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mpp4gY0hdl3enDz7UuGaAhzM9ufS5hhjJ0x9zT22R8=;
 b=iu8FTBfXmnMgy8eoZ+/wiYhIFL+hrTcSqBitowRk+pq/D3GQxVPZhZ/tyHWGbmCTcfgKJRRBhudx0UJHdJHmmsFGN6PVVrTPJYeMkX2zP0mkJ7dLCOFr0ZFw9no4p9Yyfrl7iB9Pd1xYSibL+qEDk+mMTT/j9xLHEPOxM9nEWi4=
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM (52.132.240.17) by
 KL1P15301MB0294.APCP153.PROD.OUTLOOK.COM (52.132.240.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.1; Wed, 28 Aug 2019 08:45:14 +0000
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e]) by KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e%9]) with mapi id 15.20.2241.000; Wed, 28 Aug 2019
 08:45:14 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Topic: [PATCH v3] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVXMfGJ3Qba7Bfm06iN/QPH/c1OqcPqo/wgACSKZA=
Date:   Wed, 28 Aug 2019 08:45:13 +0000
Message-ID: <KL1P15301MB026421E7481BBC5B28E3E468BBA30@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
References: <20190827110755.2707-1-weh@microsoft.com>
 <DM5PR21MB013709ADC5CB4B48CE752048D7A00@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB013709ADC5CB4B48CE752048D7A00@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-27T23:56:41.1284187Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=22d3c610-3ee8-44bd-b8c5-5b9a2554642b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68437d0d-9ae1-4a06-c492-08d72b940b82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KL1P15301MB0294;
x-ms-traffictypediagnostic: KL1P15301MB0294:|KL1P15301MB0294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB0294F66D3EF1D660E5DD9FB0BBA30@KL1P15301MB0294.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(13464003)(199004)(189003)(54534003)(4326008)(6436002)(55016002)(33656002)(316002)(476003)(14454004)(486006)(22452003)(66946007)(5660300002)(25786009)(11346002)(446003)(3846002)(53936002)(107886003)(9686003)(6116002)(10290500003)(6246003)(2906002)(66446008)(64756008)(66556008)(66476007)(76116006)(76176011)(2201001)(186003)(102836004)(81156014)(71200400001)(71190400001)(6506007)(256004)(10090500001)(26005)(2501003)(478600001)(81166006)(8676002)(110136005)(52536014)(66066001)(8936002)(6636002)(86362001)(305945005)(1511001)(74316002)(7696005)(99286004)(229853002)(8990500004)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0294;H:KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hxahiCa7gvgFhdyN4nvl6A9E45qjUuoRHZabTDCTdIhE18d4qakWG7mu0cyhLK29O4bXJTIoHVEqcvsBYRehY8VWYLyqWzYr8QBMdhLBQdfWSFZ9siwsJ/odMu+vKLSfPPAlNZjtaEdhdzvvoWL2DLrLUYhMaqxgrQuNUOlwKUkGB2X37ybU5/zAQBDx6dJ/BpINZSCL7wg4Y1Vu4Gpy6dMRtwNwRt7e9USqlw4ZHoGhZZvHV5mL8P23T/wVIuo71utvsJwNveGn1oUNJNJsgWljj6Dews8pPU0cWfC4G+Bb2pnO8Z4sVt4u78EMuARWOpsO/l8ZQryY8rjLRpsTWCspwJ4h/MHmkDWsPHwypLCdLnTP6AIKzu+6DSz7HefAP6sjYbre7X/PecNzVzLaQugQ2DZ42o8o9NqTiHdXCBU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68437d0d-9ae1-4a06-c492-08d72b940b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:45:13.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YazZyzDnT19aTQFX0p+DswxF7CDKpVf1U/JjXQLDFcAPNPHmmsJ45yyCg1W0Lk5PF56hzQtIHtNwPutrzm5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0294
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> >
> > Beginning from Windows 10 RS5+, VM screen resolution is obtained from h=
ost.
> > The "video=3Dhyperv_fb" boot time option is not needed, but still can b=
e
> > used to overwrite what the host specifies. The VM resolution on the hos=
t
> > could be set by executing the powershell "set-vmvideo" command.
> >
> > v2:
> > - Implemented fallback when version negotiation failed.
> > - Defined full size for supported_resolution array.
> >
> > v3:
> > - Corrected the synthvid major and minor version comparison problem.
>=20
> The changelog for v2 and v3 should actually go after the "---" below so
> that the changelog does not end up as part of the commit message.  Take
> a look at other postings to LKML for an example.
>=20
[Wei Hu]=20
I saw people putting v2 and vN in commit message. The git log of this file =
also=20
contains similar lines like v2. But if you prefer I can move it after ---.=
=20


> >
> > Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >  drivers/video/fbdev/hyperv_fb.c | 159 +++++++++++++++++++++++++++++---
> >  1 file changed, 147 insertions(+), 12 deletions(-)
> >
> >
> > +/* Check if the ver1 version is equal or greater than ver2 */
> > +static inline bool synthvid_ver_eg(u32 ver1, u32 ver2)
>=20
> I'm being picky here, but I would call this synthvid_ver_ge().   In my
> experience "ge" is the shorthand for "greater than or equal", rather
> than the "eg" you have used.
>=20
[Wei Hu]=20
Okay.

Thanks,
Wei


> Michael
>=20


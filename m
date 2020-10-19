Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B029214E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Oct 2020 04:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgJSC6L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Oct 2020 22:58:11 -0400
Received: from mail-bn7nam10on2111.outbound.protection.outlook.com ([40.107.92.111]:33441
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728538AbgJSC6L (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Oct 2020 22:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9ASfBujFbyoecWvYg4MkW3nTYKdTfjP6tdI48Hodq64ar6rgjG+jM1ad9YxeD4zuULFUYYd/Oao2WIF3X3wVVMWXilnM9EVkFFnxZ9UV5a3pnEH9o4aB6/pOL1xy60oppE+hNu7LgXl30wGIQGdKXLrt9hZ+C5Y0/PXUaYi14S/2ZpWcWK868VBfBdsPpRen11zoOQ5iKO1nG3e+1ilP63uq+WsCrmqz7mXwH0KIMovMlmfmix7XLQSgIqDuPO6JMb2NCRTsEkL3EmumJ3a6TCWqgieO3lTbPkmMO3SX7ZLSt6oMWKshM51Xt164gKGkGiOA/AIAXuHH0e168jGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGqqrrfNniopGKPB0R8nsdSW5ymhPio1wCd4LGKOPAo=;
 b=ZzrBMLSzu9uYYKcvw6ZvWC6XEqUM1aOGZjz4ogHqPu6yv5YUAQ+zh0NHux1j/JzzZZkXR7gbs/nfMZxWigJisEzWwydzCDSY5s5gWNtuO3wc67upRg5PqQf/JmFKhRF9ZrzaVURb8Fua5rWLApnNbh26e19MQJbrT3snD2gLUvq3iRg+P08NxSjmdrITGmd4RCIg8ptESP8guBf+AiGo8VifwIfEFvGsi47xkxLItZcC3jmJv1kdBC2rQIzqXJy3P8JeWuUutH9kCjjUET4pw+ImgifTwAgZLhmGrUKnG122Be8kCnqAcCH5akrjX8SlvEBZ2X1olokJ7TjGS/+24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGqqrrfNniopGKPB0R8nsdSW5ymhPio1wCd4LGKOPAo=;
 b=MRfERQ2mQleOV7bF69tbk5757BBm2zHO8OB1UvMc8XgdwAr6BvpNY19LpsyaoL5EMGxdOP+A1GBrJWpLwlQUjx40IRtIX2ARlXQvfRsFzav9488W8IusDdWrkj4uEeN7SGvU42wd4sxhCqoZEfzBJFL/OSAKopFH7bYLFPZtRoY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1801.namprd21.prod.outlook.com (2603:10b6:302:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.15; Mon, 19 Oct
 2020 02:58:08 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::101a:aefa:25a3:709c%9]) with mapi id 15.20.3499.015; Mon, 19 Oct 2020
 02:58:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v1] hv_balloon: disable warning when floor reached
Thread-Topic: [PATCH v1] hv_balloon: disable warning when floor reached
Thread-Index: AQHWnUJmr5zYZi33iE6Qbgpur5d1vamNSyGAgAf9pICAAACUgIAABdmAgAj9H3A=
Date:   Mon, 19 Oct 2020 02:58:08 +0000
Message-ID: <MW2PR2101MB1052AAC9DE9A4829F53BB493D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201008071216.16554-1-olaf@aepfle.de>
 <20201008091539.060c79c3.olaf@aepfle.de>
 <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
 <20201013111921.2fa4608c.olaf@aepfle.de>
 <20201013094017.brwjdzoo2nxsaon5@liuwe-devbox-debian-v2>
In-Reply-To: <20201013094017.brwjdzoo2nxsaon5@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-19T02:58:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a7b1f9c8-3ec5-42fb-8002-dda3f5eae8f0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90fe51a7-924e-4302-246a-08d873dacedf
x-ms-traffictypediagnostic: MW2PR2101MB1801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1801B08BCBB2AFBC34746D6CD71E0@MW2PR2101MB1801.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfcI3ui/uK9lKh9YV8G6t2fFMLjKNYrzdbA72kqsPW+ST9l5QwlcJiEt6KAo9Jgyx+kzPaWgOHwl8lhXUE+Nc4/k8xBXDo+ToldDrof/MO8PX8PqcMJ7BkuqbsRdisbSnxbEqfHNyZjFoI2gGGp+7Ngd5vChmsLPGJg9n3xIOFNV8Q2NgkiK4N9hsWzh/lrzycoyZ0bmK4w2wE7G/XdhmaOWIYCgyOmpE89I2jgk8wQivGdAzxe725SlH1AG0MJMH201aZLmuLMpFrEjhmOzKW7hARnq7U3GCz921wR4Bk4pDuQHWgIKOGgEOPfU2QeSYbemDo4bIbWMjoBN0kVdog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(4326008)(55016002)(82950400001)(82960400001)(86362001)(107886003)(316002)(52536014)(186003)(83380400001)(8990500004)(54906003)(110136005)(66556008)(66476007)(2906002)(26005)(6506007)(64756008)(5660300002)(9686003)(66446008)(71200400001)(66946007)(8676002)(10290500003)(76116006)(7696005)(33656002)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7U3sWOr7Ks36umT4Cq2CutwlhITjGHU0LBqPCTVG+ebKBgX3ScWnoMeBzkkE3it20LYoezIl+soZY27PCazXqz/cgFpYBbWdmxOPNM+LFU5pM8YEK3ZLporTT08GH8JqODZdeBrBDEOcG9XAyHJr7Z3Jsp3eiDALp0SrYihgZIwlLR21l0lF6pqeOzTBhZOGewez2AhW/aEH6hghXRX5zApCCfPMOgln+Oh/lwpIPCWf5h66aGYDt3cFmSr6lF2c6Jxap8DjcBGDaHHQBbpgb1ZsAgZHZ16aZs4O3zbGZSudf8wP6DpDZjHedcteBRWyVRYID5cEsyKf5dhLLSZa7pGeY+pcBOu9GD0+onHBpiv8488zWLdaWfkOHnol2U7c06y+oPvpNtV2is2NYaDjYBh3OZBC5IkD6HXZmY9W2KhszM3y+1D7Ev0TVv3W1FFlkMPNQPNfQz80h0QzVbEzUuLk2iizHM3RGGmrA5elCvF9Gap7/FfNZ9y9W7rvkqp92YdFhVt/kFm4mxYHt8uhrs6/CITRE8LHMCJdq2LrQqelkDHptGWm7xUgbllErgLs7VQBV59HFCGDqGro5whiuO9PTn+xj4p7AUl7wrVMT4bIcXca6W4yyPWfEu7wnuuL7TpqyI7XDG5cWfS9kKysCw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fe51a7-924e-4302-246a-08d873dacedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 02:58:08.1981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZunehpD2A9Ru1TSVkK0zkDpLBDvP3KJ7L8WyBEZBYLe0RrenvmnnO7bkHKzcJLaeWHBOgJj/36NUZxlhEAT6NgAyRbi1/yKAlmLDtgho0oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1801
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>
>=20
> On Tue, Oct 13, 2020 at 11:19:21AM +0200, Olaf Hering wrote:
> > Am Tue, 13 Oct 2020 09:17:17 +0000
> > schrieb Wei Liu <wei.liu@kernel.org>:
> >
> > > So ... this patch is not needed anymore?
> >
> > Why? A message is generated every 5 minutes. Unclear why this remained
> > unnoticed since at least v5.3. I have added debug to my distro kernel
> > to see what the involved variable values are. More info later today.
>=20
> What I mean is you seem to have found a way to configure the system to
> get what you want it to do. It was unclear to me whether this patch is
> absolutely necessary from your last reply.
>=20
> Some may consider the log informational (like you), some may think it
> warrants a warning (because not enough memory).  People also don't seem
> to be particularly bother by it since its introduction in 4.10.
>=20
> I have no objection to applying this patch. I can pick it up if I don't
> hear objection in the next couple of days.
>=20

I think we should take the patch.  We've had a complaint about the noisy
output from another source as well, so it was on my list of small things
to clean up.  Thanks for doing it Olaf.

I'll send a separate Reviewed-by:

Michael

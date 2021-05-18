Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FDE38826C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhERVvm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 17:51:42 -0400
Received: from mail-mw2nam08on2093.outbound.protection.outlook.com ([40.107.101.93]:56052
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233561AbhERVvj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 17:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz3BGCSqGNB9kMzHF4cqT9zSKQnU7zl6QEeGWiv1adBwPKgXWLY5nhGtnRf0UWgYaHBGb5EVySSxX1PU5W65TdTDGy2+GYpVj0ft4UUxJ+xVcyAOAW4AshiAfhUjHkAC6VzVNeTLiMwxJMFBiuP/A5/7hZ6qRCuDoIEF1jd3mhon0ICrBh4kMq8EhtE6hf0CmpkOie1ZWzOMaDAlATkDB98b9R/wRWwdogJkTW3A+RiRJak+tLACt/mjMc/AXCpO1QawtivKlSVFDnD/c87h9Z5PYKqhpD268KcyYjc7BSvhCS0C4xtnKKWyg/x40PhbtzTUEabyxpDo2+i7JFMzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byMufl0EMfOWGSZREWy4DYY45LckRdbil6GCly3M7ko=;
 b=ALIrWNnw73EOFfe4xdDuoGmrUxbvpMwaHN7ne/kgMZaSgWLEhOJWgstHL9JQNnp2bHDiKpHsk9yY2++mdi76CXd/o4y3mIhuZ62npFMEAoXaBTsHqH6iYMZ57gewxdcvSyOMNFWDlsVo20WTprK/G4bBii+c2TJ+A4cwBSB/5NxUdAFwwDMXOqDfA5i9qPntay9dJ328p7Uf8+PRClype4r3mu3EKlbRRzz4IGIqS25YDbiuI5LwKYZ8UUT7Nc/AHBzIZkMfHboPdpvXm0LLuX8tSK2WqN/+RHdwqJi5JkdiU9WqkvivqbfQ5NFYWduNYXFAWyhHe/50B7gqXNQwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byMufl0EMfOWGSZREWy4DYY45LckRdbil6GCly3M7ko=;
 b=UgX+Y3DaksnRkP1tKh6+aEE7o2T1wEvK22DvSya00RyjH0bpSVuMZIB8qHgj//hz9c8b5uxSQ2L1ZqWCOlLLZTzM0LJcFK5eAvVG7fdW/McN9ZbGO7mR97X5C2Hx7FtPqke1UMJBrX3h3TfreOXf75WGPPv/qOgS3qDg06pe+jo=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1444.namprd21.prod.outlook.com (2603:10b6:a03:233::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.2; Tue, 18 May
 2021 21:50:17 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b1de:537f:9fcb:8f9a]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b1de:537f:9fcb:8f9a%5]) with mapi id 15.20.4173.010; Tue, 18 May 2021
 21:50:17 +0000
From:   Long Li <longli@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Thread-Topic: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Thread-Index: AQHXRKLL7Wa+gDnCvUOqwoRXJ6f8GqreDW2AgAsTkwCAALQjcA==
Date:   Tue, 18 May 2021 21:50:17 +0000
Message-ID: <BY5PR21MB15069658A7DE04A863C75036CE2C9@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
 <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
 <20210518110122.7jbktl6olsl75vqz@liuwe-devbox-debian-v2>
In-Reply-To: <20210518110122.7jbktl6olsl75vqz@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afb4a952-c64d-47e5-957b-33d79ad41a3c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-18T21:46:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17c8d8d8-aaed-4e18-3db6-08d91a46ed38
x-ms-traffictypediagnostic: BY5PR21MB1444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR21MB1444977F2EA8B7B84A6A97DDCE2C9@BY5PR21MB1444.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6MhXbAqPnz7rh+54iahz6JnKChMgIpYfAgpXGWocHLFGThWtRthybpexi1HyWWLF4tH+/JXXV97S3XWtukbfdZYmNQZPUaWNykbVSNSHTyorTlIzBHwDT1FXc7janpLDvoAyknCwR6Du8tKgLyly2UN9rtjTHW/ptmkvHtCRGcAohGtUCSSefCxTFlObnYZ4fCdwghzBUIOTrlm6ulM6Jse3WRZZUtHjSRVo4v+gCll0EP0t8DccK+quSfmhYKSvukmkLE7DuQEaZXyCwuDa6rpSws9wn+hcMX7Nbc4PSRy5vjVkuu6Qr/XhoZZLzcwSHepw0VvWR3tou65JaPRJRjTqTFC+6GLWnaZUaYR8glMk3ySSjojLQwPfnHZVONz2tkrtifGArpJWS/h4B8jXa8rjC1kbCXFX6A3liSLFfCz2ozZlv5K1yUgBeS5f60DXFVQzBPvvKfsTVwQ4o2vq4xM383f/tdbUoPuYyLZ5x70IA9XBkh2+Q/0uxHyl7e1Y61FJXfaDatcDyWAR8ZVWAR8wVsyJLRIuZ198zZ0qwxio8NVMOEERBRwiDvtYTh4OHR1NH+qN9Zuz10VUBiYnK9xZ+AvyjCVYcazRcWKCNIrm1yCbB7Sm+qUihTg+1ieRnnWGp6hkGwZoGtCx5nT1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38100700002)(5660300002)(8990500004)(8936002)(2906002)(122000001)(9686003)(66556008)(54906003)(66946007)(7696005)(52536014)(110136005)(82960400001)(82950400001)(64756008)(4326008)(66446008)(8676002)(55016002)(478600001)(26005)(10290500003)(71200400001)(6506007)(83380400001)(316002)(186003)(76116006)(86362001)(33656002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJE0QIYXJaQlwwx4c1Zr7toxpeLIZGrtCURbLqp9HrjHKPfpXoZ42rej13wN?=
 =?us-ascii?Q?m2uJDPK1HLwQChsv6svcXQNyI5RbiqBqbQ7mdhsjgRPnoT8EIYUWaVVX8g97?=
 =?us-ascii?Q?6u9F+wp+s6fhlFEXzZrAPlWHG7o9qPyXXCij9RQyty7twA44+gfoSZw1kBsn?=
 =?us-ascii?Q?PwSph301RisLIAoh46niLAN97gXnvG13OhwZqJn9REqmX4Zys/8KT8zh5Aa+?=
 =?us-ascii?Q?yR12GiKdY+dfDb2qIWPXyXzmQQRi1NPzMtta7y0XNDFhrN5lsnSAer7Gahy8?=
 =?us-ascii?Q?Wgk1O0oTKciIVDX4wrKPxY5ja5KsmTbiWxoZXLPoLSNWTyrRyIZBH58+iEfc?=
 =?us-ascii?Q?ibyGSv79xL1hbRci5tJrxGZV1Yu6GuqJ9lSk00Mn2pVQgt6ADs8msjmp3ueo?=
 =?us-ascii?Q?2SZ4Ak3R/XIZ7QwJOb/WA3Tx2hGalIAIaq9wqU/KQpzKem2RFyMiaxJeN3hs?=
 =?us-ascii?Q?qjto11TCfdpS3kGS0bYL8YqXioSsyY2gHsN7dYLONj+ryZ/UM7p8OITUPBZH?=
 =?us-ascii?Q?I5tjhWv3ZOFS8Kn9Z6GoaqoIqWy3N3k2IxBj2+3l71kl2TRxAAIhQod2cy3h?=
 =?us-ascii?Q?pgoJv5MrCpyU34T/IkSLrv+MzO4VdFdTHUw5TudxvEolKj1QY2T+kHiRapWE?=
 =?us-ascii?Q?OXtpdNlaySYjHfMRMrW8AwxK2KKYfz4GKWKPoO8krHfR2dS4EZ72t4qYXvHk?=
 =?us-ascii?Q?y3hQ2DY77+iKGcGT9FtZkXCG3t8JFnzrUA6FydtQpMRNtTmiDY7fXMNy2KFe?=
 =?us-ascii?Q?qN/QXkeEYD7VkRU2TlYLhup+pIl1kCMFUW8CM2O6SRyQvV8+makvAU9+JmXV?=
 =?us-ascii?Q?/VkLg3mF+se38C8PC8o0KWm2OTvYNLm5ZDO9DWk2lZveV7aoDyAexscjUSr1?=
 =?us-ascii?Q?ZkGby5bNIW9GTRrJYzL8Eh5Crf8SJauWsaalqsoqlu1pgbxeVJYZ+PcoKaBX?=
 =?us-ascii?Q?ZYqYzPDwXfIBgLHLxHr9op9el8dv4Zlwz2X2RCPu?=
x-ms-exchange-antispam-messagedata-1: hGYBIC7mLHT4u/YzJLgcRy6HSNL4wqdvcQx7F13g9EayMi9RWpxrHbUepCuvNLo51NqGINsn9cZgkNDYmZm2c6IywlcQsZfCbCSAGIUAIuUOMWpAyP1QGdsTtLrl2IwLNZjqsPAfoxNFviBoHWVeUeN/2VWySNT6mSkMhVKf3mnIpXKlEEsLnPLBMHqlAAfRPfyuGphFlynpZYixzQED3KGM0jRl51X+GjKXQKWRMmGXL9UOhJAEh+6fJuRuPqAKFNStAAklv92hxfB+bli1t76rVeFNDhEZwAQAo1mzUbc1fsrb4ofcj8tsuZHXPeuQEIY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c8d8d8-aaed-4e18-3db6-08d91a46ed38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 21:50:17.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKwv63VwmZdzrmuRgV9Vlpj5gzvdN/MSUINN9d+3VF2G4g0bmSocHtiNQPnNugBb0iUOyfNmv5ntNrsuAiFQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1444
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handl=
ing
> paths
>=20
> Cc Long Li.
>=20
> Long, Stephen suggested I check with you. Do you have any opinion?
>=20
> Wei.
>=20
> On Tue, May 11, 2021 at 09:52:27AM +0000, Wei Liu wrote:
> > On Sun, May 09, 2021 at 09:13:03AM +0200, Christophe JAILLET wrote:
> > > If 'vmbus_establish_gpadl()' fails, the (recv|send)_gpadl will not
> > > be updated and 'hv_uio_cleanup()' in the error handling path will
> > > not be able to free the corresponding buffer.
> > >
> > > In such a case, we need to free the buffer explicitly.
> > >
> > > Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until
> > > first use")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Before commit cdfa835c6e5e, the 'vfree' were done unconditionally in
> > > 'hv_uio_cleanup()'.
> > > So, another way for fixing the potential leak is to modify
> > > 'hv_uio_cleanup()' and revert to the previous behavior.
> > >
> >
> > I think this is cleaner.

Christophe has mentioned that the patch is already picked up by Greg KH.

I think both approaches are correct. We can go with this one.

> >
> > Stephen, you authored cdfa835c6e5e. What do you think?
> >
> > Christophe, OOI how did you discover these issues?
> >
> > > I don't know the underlying reason for this change so I don't know
> > > which is the best way to fix this error handling path. Unless there
> > > is a specific reason, changing 'hv_uio_cleanup()' could be better
> > > because it would keep the error handling path of the probe cleaner,
> IMHO.
> > > ---
> > >  drivers/uio/uio_hv_generic.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/uio/uio_hv_generic.c
> > > b/drivers/uio/uio_hv_generic.c index 0330ba99730e..eebc399f2cc7
> > > 100644
> > > --- a/drivers/uio/uio_hv_generic.c
> > > +++ b/drivers/uio/uio_hv_generic.c
> > > @@ -296,8 +296,10 @@ hv_uio_probe(struct hv_device *dev,
> > >
> > >  	ret =3D vmbus_establish_gpadl(channel, pdata->recv_buf,
> > >  				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		vfree(pdata->recv_buf);
> > >  		goto fail_close;
> > > +	}
> > >
> > >  	/* put Global Physical Address Label in name */
> > >  	snprintf(pdata->recv_name, sizeof(pdata->recv_name), @@ -316,8
> > > +318,10 @@ hv_uio_probe(struct hv_device *dev,
> > >
> > >  	ret =3D vmbus_establish_gpadl(channel, pdata->send_buf,
> > >  				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		vfree(pdata->send_buf);
> > >  		goto fail_close;
> > > +	}
> > >
> > >  	snprintf(pdata->send_name, sizeof(pdata->send_name),
> > >  		 "send:%u", pdata->send_gpadl);
> > > --
> > > 2.30.2
> > >

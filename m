Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E321429626
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhJKR7J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 13:59:09 -0400
Received: from mail-oln040093003008.outbound.protection.outlook.com ([40.93.3.8]:19871
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234097AbhJKR7I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 13:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHmjxJt0stAZXosHmdJVCxBtro8XsnwMRfdfGrizHb+Qni+C7q1dOmRWQP6lY+sU+9CpnFB84wAZ7q90gfeng0vkuYr77a6ikEmPnuDe/z1L2A5JGMdapQHO5OaXYU/kARBWvYsWTom2gWjlhxmF6HGDFj3uD8crncF3zu1lWPC58Tv+zqb/aEwhcXX0QbVYBbOqWgZvFfCyICYeKwva6uvz6XhdzedEBTDn7K/87gMaQhNH4cX0u9o6ANYvT74XynxxqmVkG8wTi4KFdOV11tihX5yGyzscV+VcEnqP00jNkLs7qNQjsokSbeiQnnKNPUkYiQOJfO3yz/ugw3GPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYTo0wvdASxuXuD2W3UaaWjrlLRoWBjsYWMnzcw9o6o=;
 b=Z2TIDjp9iSMl+cCXzuft4JX/UezND15YOnAYwKGmX0rXWMqOoBuBi2nL4KGdOI2BoCP3SAiGD0kCV7cMdoUP7oBJ+q9nwkci4qehgTUVtRrBlIzny7Bmgi0wI97QBDdWQZ5aQMPgVX8dKgiFn5tBzTvZvuFj1bS2M5P0lVmxDRVIR4UdCKcuepLc9UUj1720c8ZdZiBuuUpE/jO7hglJwGA3IqEQUP3O2h2xABtg5txTkvx9x0mC0FVNyh/jXphr9iFMCWaDEEKLMaIeInQSmXm6Upq+rfVhPmCd8LdRU6JJaYJRHaFFYXmN2jqDE2+JT8yEtfY5P1FL/v8awSvegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYTo0wvdASxuXuD2W3UaaWjrlLRoWBjsYWMnzcw9o6o=;
 b=HLUNXV1Lxs6mn9kxZROnl7ybWaCz3Dn6/F6bsq9p7pMtb/8ok8k7zCNS2zc/7abgpEIxz9VkegmKTAtcjqTxLhwiVqtXXS7CUHKbGFAAS2GCKJaw/fyowk7F7owo+IolqbZS6qHG3iGa/sYF+Y0keR2qR0Oe6FfNFG7x+Qk/FX0=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1205.namprd21.prod.outlook.com (2603:10b6:a03:10b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.3; Mon, 11 Oct
 2021 17:57:04 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::6472:67ea:9a66:38a4%3]) with mapi id 15.20.4628.005; Mon, 11 Oct 2021
 17:57:04 +0000
From:   Long Li <longli@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Topic: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKCAAJ8QAIAKHh2wgADF34CAAFhQAIAAAnmAgAAkEQCABQGIUA==
Date:   Mon, 11 Oct 2021 17:57:04 +0000
Message-ID: <BY5PR21MB15065897C3D2461637986D60CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com> <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <YWApWbYeGqutoDMG@kroah.com> <87a6jj3asl.fsf@vitty.brq.redhat.com>
In-Reply-To: <87a6jj3asl.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=72ec35f1-a8ba-4e74-916e-a927c4d87014;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-11T17:55:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3aa11ee-d204-464e-3371-08d98ce08903
x-ms-traffictypediagnostic: BYAPR21MB1205:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB12057D14B6B360F8AE99B7B8CEB59@BYAPR21MB1205.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LANveNzB5n8NX60KsPVS/DASASDlTb7sLTFzQLqiOVxdu+DGrSR94ZiPw/Tppf8kYw3+U63b7vhnrBAyDkutHnMDXQv0PkLZw0ZypDkinexQGUMk3p+xJUMyA4Cu7M6DG51EhVw/c+rX/dzhPqEKYN8/mxaxWHM/hCTPR+EaxaWTkAAKQ5UgwJ0XHjvAXeMeXT6dikzmG2yMV05ZJSKM05cdRqMjwtR8WoVceC9XIq1HTEeeWc+V2RnVxc96nwyO0fD0k04XC/aZJDeEqIHEEK7oEYHHS+lKqIQcC5om1AU4uw/ARfmG+whXkAHV0nGt1si29eAANDYPeeIMuV0CtXMJMiBguPbmwoejtLNLa3kx2ptptVGYEPJn6+Gd1EsdoJthDxO9Eed0hs38zrDusylQuOl2qbniCAn1QXfimuTMCcGjMgbYY2WGjT6wJm74GkjE6WkRaxEMYTt286UQCUuEg/6BG2F+trrlQKDWUwtqCft9sVrc+mGbYAqZLCY/5YPiVbbZpQhIPCTaEYJLNPrT4hK5qiocQtObp21hobzl/tjuVvt7h5pDefSQVxIAdRxTRxVnzFjftasZwysEFvIVIbYSjBf1rUZNoNIbX5COrzNgvEuKaN+gFvAnABld844ocr23iDBD/Be9woBB6jM4daLG3JGWILmSW15+b3nOtNSd708fI+qpY1E2C6XNLq8Ad48ujRtB2Bgy8Fcx0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(76116006)(83380400001)(7416002)(82950400001)(66476007)(316002)(10290500003)(82960400001)(64756008)(8676002)(186003)(66946007)(66446008)(86362001)(8936002)(66556008)(4326008)(38070700005)(33656002)(38100700002)(26005)(6506007)(6916009)(122000001)(5660300002)(52536014)(54906003)(71200400001)(8990500004)(508600001)(55016002)(9686003)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XFVeSvR6RhVZAR6SvWVd4cAPo8x2EJPzQhFHeuxm+UR75nzejQEApFjHTAH+?=
 =?us-ascii?Q?ZQxpJ9zuvMnTS7qRNcF5cI6FXgRNqAtjeKSu7ig866kc60MXFMWXlRLY1h+f?=
 =?us-ascii?Q?5WcmCclY9U/a1Gu0faSITVuZyprjup84kaw8cJgzgonzTWlRtlTxgxs5NEfm?=
 =?us-ascii?Q?NFksU979mXT4tLJzV67VT98XvgwUQ0cTuTUUo95psHJh4w1FBAl79/fEyzXY?=
 =?us-ascii?Q?HOHIDO8NjTbnMWV4ROWZM1yGRlW+KqW7mwpGcylXcnyNpm0rPwxF6j5smr6P?=
 =?us-ascii?Q?v2gkAEc55So12kOExg67OtBlzNRwuWubO2n3Jyiud1gGqi72nbvsLIt6NPCM?=
 =?us-ascii?Q?VJxceXP+gIOvVeHuo0+8YjGmUsg7R3v4EhT1kENn8nhOFmAxbwv3x2a1k81L?=
 =?us-ascii?Q?lgSyC4ZBVPLLPIhrbxqhh+M1oIDnL3r8vZBys5KEvtKkiPXnb7GfQBeiup7u?=
 =?us-ascii?Q?TBYztggODi1nsZvMrgOM0H/VYx5oNyOedRQkQ8rrkKmZ/qtuRuE+NCMijMCa?=
 =?us-ascii?Q?CVLR94o9VQnPFYfEePoA7KhmMAo0CclHP+ojVgo6wz2zOx7v+EEpb6n+9UzY?=
 =?us-ascii?Q?ZwDUjK9OwW2mtjghVfPM+whINUBwsXRr2oAdNWETTgOKyLwRymXWgZZR+uxi?=
 =?us-ascii?Q?CPR85jMWQxlxLrEOWADL7ezf2YID43sQ/0WINyhGWsephYoM1GouXatseqiC?=
 =?us-ascii?Q?XnUxvjl5bUVDhzvA+wUVafyoj1WXtuR9MFN/22B6+w1kX2JMh6cOYXTcv3sh?=
 =?us-ascii?Q?ylIXf0o3ckPa9RD+E9UetdpQEBbIYtEJJCwrBYbzEqnNE6fA0Gr9HT3qa5Bn?=
 =?us-ascii?Q?v0NjE7U7lEcyTqiFmcBRZIQAZ8n8H1Wx3Nz3KfimtgJFWh5t8YRxVW2OhZvW?=
 =?us-ascii?Q?qZl/X2ta8z0mi13Z5jhJkxxjDUHN0v581YARVrGOWj8j6jfSjEn1rBLd+KBP?=
 =?us-ascii?Q?ZMnuHP5CBLQuhvf/CyeYbckKv3asN5RFpTXe80lg+CF22+ftzcjoPFPqM4bT?=
 =?us-ascii?Q?I4J+SKY3asUi4ZjUBc2nz+Y8afe8cuKGHWYMhuW00kIs9lGyXWCaGP8KLbM6?=
 =?us-ascii?Q?rPw9jCklYRxCu2ZMiOqv5jeFqJrWM3vX2WndpPUFHLwicVLugHDZL+3PYeOq?=
 =?us-ascii?Q?PybC8cQUixxhV8yp0+NY3bLnNGyXNQoi7dAJk0IBAw4KKx1sznOQOCNNNAED?=
 =?us-ascii?Q?XD16gDdXKEZ1/xFrl/BhYtlT1B2TU50naWVQgwn8b9OjXSEZNdz/8LZrpjz8?=
 =?us-ascii?Q?E38/SuwPnDz5RKBVbSyRWhlWR5Aqor0ELgEsaLVrX0Tc8OgI5qPEwuVO7/Dt?=
 =?us-ascii?Q?83+ZiFTVLb+Ty373EimubCgcM2Q//oECLaTNixGrK3FXnCmBYIp91PWJ5p9p?=
 =?us-ascii?Q?7OtAAhYvAOosDAffMfiKdc4YrDeJFEAxqEM6xt9xmQZI0NgO6nXh14aT8OHo?=
 =?us-ascii?Q?sEatC4uPmMxhncsr/Vy6SZ5fYclFJt3tRpc9x+bfsLlxwXIWrvtxzstli6Y+?=
 =?us-ascii?Q?biST53QPdm/P/ORpM2zloz0jmS6rgq/D4nstvof+xs4qHJdIXLxJxmWX1coB?=
 =?us-ascii?Q?VQ7o5HCz4FON4yQ9WXX33Y53IdYBnMQy4TpQRY9dSF1i7MAPJmTXcxqJIxNo?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3aa11ee-d204-464e-3371-08d98ce08903
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 17:57:04.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W02U80okzFfGB+UJ1K0Nh4fbMEn0UFXZTBTiiiEUdzIXL2i8UiQGDH6C5zLcRs0q3q4qertijZiOxiE9y+LnOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1205
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d access
> to Microsoft Azure Blob for Azure VM
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>=20
> > On Fri, Oct 08, 2021 at 01:11:02PM +0200, Vitaly Kuznetsov wrote:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >>
> >> ...
> >> >
> >> > Not to mention the whole crazy idea of "let's implement our REST
> >> > api that used to go over a network connection over an ioctl instead!=
"
> >> > That's the main problem that you need to push back on here.
> >> >
> >> > What is forcing you to put all of this into the kernel in the first
> >> > place?  What's wrong with the userspace network connection/protocol
> >> > that you have today?
> >> >
> >> > Does this mean that we now have to implement all REST apis that
> >> > people dream up as ioctl interfaces over a hyperv transport?  That
> >> > would be insane.
> >>
> >> As far as I understand, the purpose of the driver is to replace a "slo=
w"
> >> network connection to API endpoint with a "fast" transport over
> >> Vmbus.
> >
> > Given that the network connection is already over vmbus, how is this
> > "slow" today?  I have yet to see any benchmark numbers anywhere :(
> >
> >> So what if instead of implementing this new driver we just use
> >> Hyper-V Vsock and move API endpoint to the host?
> >
> > What is running on the host in the hypervisor that is supposed to be
> > handling these requests?  Isn't that really on some other guest?
> >
>=20
> Long,
>=20
> would it be possible to draw a simple picture for us describing the backe=
nd flow
> of the feature, both with network connection and with this new driver? We=
're
> struggling to understand which particular bottleneck the driver is trying=
 to
> eliminate.

Thank you for this great suggestion. I'm preparing some diagrams for descri=
bing the problem. I will be sending them soon.

Thanks,

Long

>=20
> --
> Vitaly


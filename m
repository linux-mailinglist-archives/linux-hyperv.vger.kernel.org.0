Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446C31E30F
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Feb 2021 00:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhBQXgJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 18:36:09 -0500
Received: from mail-dm6nam11on2101.outbound.protection.outlook.com ([40.107.223.101]:30081
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232478AbhBQXgH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 18:36:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvJ+EUCHqNuCzrK+MZfIH6eAZLWwYuKTdLa27rzZBK9i2L3Rk9/owmUyCaVRxymV8busA+t6vY5dGHpJxhWHQAlOthOKUzPKwyrtUWFjW7JOy9Xj7us/gmaXhjwieYrMkCxsuh58ATRPrSswEU7tlKSTUUGpC/K1hZ8GfDM1WwM3EUnxK5uamOEvVfBnRaoJhTnoJ7gMleh5lyNQgbvekt23r4NJdCGauNxZ4Mdr3c69dCDieb0TzEsbZG44Sgrc9TRZFC/6+I7+c2iZckgtKlZEEZEzNdv9KGkWUa734W8jv/sf+GUYNS6Gf1umpx5OjnUfjqXFEcixut4YAUmPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6VxYQ5a5nwJoh0Eaf8NjK0mK/qan8ADH/BpVFvDWQ=;
 b=MW9JhqjG5LonMEpM8pT+DZLIVskM8Yuunw+HjsOUPx8G+04cqkK3Tx3xSi5Sb9+XSZs6CWf8XvrE9t8TkqWsxfxm1lKg6ow0uxg4VFZ5u5C8Js1/cyunfXAC2R+zNIW1K+zk1uF+HPBvzqX+MSYXy6/1NroCMJae8oalQ+fsrXCyPxZHLu3WgRRFKrioS0l2OQ4SQJvaV002/uoqWfeStwoOjTrHUElDGP85Y67oNabxk6tmL9M5B1i8IxyAG3I03nT6izl/nuQ+rVRm1zFWnrUjFWyUJ3QYXzyWRNq9PPmMBq5/g9xZvlpZu4oFumOZE9m5e5ylJ+0KMCIM0bKlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6VxYQ5a5nwJoh0Eaf8NjK0mK/qan8ADH/BpVFvDWQ=;
 b=GRIh9WhzWZKeJwEusvx8a3g+eoDNtGOmNNCBFu+XpPkGszrDJTRpHj4KcX7zNSap6U2Maq5RVzNT9UGelKNH1cqTDrYxXgHkX0MlST+GINRzacx0SmpwOqtXqUvrtas6gBc+5Si0FYp+liMPSWAfzSOZx5HZrojdpU+05B+C+YQ=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1034.namprd21.prod.outlook.com (2603:10b6:302:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.15; Wed, 17 Feb
 2021 23:35:13 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.003; Wed, 17 Feb 2021
 23:35:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vasanth <vasanth3g@gmail.com>, KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Staging: hv: channel.c: fixed a tab spaces before space
       hv: connection.c fixed a "=" sign without space in code
Thread-Topic: [PATCH] Staging: hv: channel.c: fixed a tab spaces before space
       hv: connection.c fixed a "=" sign without space in code
Thread-Index: AQHXBTiV4K3/hF0cKUaKi0hsvp4wQKpc/GXA
Date:   Wed, 17 Feb 2021 23:35:13 +0000
Message-ID: <MWHPR21MB15930D979877196E44E48F41D7869@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210217142228.393370-1-vasanth3g@gmail.com>
In-Reply-To: <20210217142228.393370-1-vasanth3g@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-17T23:35:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e4015c1-4e96-4971-96bc-2b76121369d5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 428a566e-24a2-4bbf-de63-08d8d39cac8e
x-ms-traffictypediagnostic: MW2PR2101MB1034:
x-ms-exchange-transport-forked: True
x-ms-exchange-minimumurldomainage: kernel.org#8748
x-microsoft-antispam-prvs: <MW2PR2101MB1034951F2DB6C4619F76F47FD7869@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Pjy7D2pNtqjYtw62pV9FBjCsII+MpOLyTuDdzaG+cuW8xahqt6MjUoyAuJLWveOns41sXTpJ5r4djulNdDP7NMH52R1wnzJDM1dFgQWw3qjfUPRxo8if3e/N3Q+LrWYFA99JZtuDO/6Z8nCcCYYBZOFu4j/5IZ9H54HmtZDDZ/A3o7YOodkrkRp+gDGlSsL47bybbEEifRd8bJaKAYCCYAyGc9P4Dgz3Ar5/FnvYEJiuT8YJ/iZ2Rb5n66jONUYGryzSXFANZucV1dKEdPjzj6pOJ2432Xd6iWM+vkngGppealfvEQ5UquzHbTrqw7e6CuS058WAC4Hu31W2s+ZXpcZkkGRYPbHeT6cP04NoGhxndbSxGFx+plHEnaECOYEwcZWUWBy4c7++U8S3Bx9QwAOCdUGCICmEmKv1ep0JFixfkS6cNehg1vMM7AmH+oarvIDlQ8ffb3lhsKhW17ygZf0TZTk8Bip7ofxR8l7yDk7VMxcRb0Qq58Z+p7je/Akswu6+AXWwMJQyQvN1cshU52TuAeUHOWiCnEpZHLIXhFZY/L7+JfSJx0Q8qq/iMIIYvVWuLtPw9qeTFLPrBobZeh+z7ZKIp1ch9241u1Yyhc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(478600001)(9686003)(66476007)(316002)(26005)(33656002)(5660300002)(64756008)(66556008)(55016002)(7696005)(186003)(8936002)(110136005)(52536014)(86362001)(76116006)(10290500003)(83380400001)(8676002)(54906003)(4326008)(2906002)(82950400001)(82960400001)(71200400001)(6506007)(66446008)(66946007)(966005)(6636002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WTJ5RmiKAiFJJpmiZ/66acJICcjT3puqApNsk7erdB14C3qLBm2YzLUXcpgC?=
 =?us-ascii?Q?GiNbePdC/cMCd3ucfNDMRXMs8LrqkySjLutLH+SG5FSbTrnbu14NWpGP3Kfz?=
 =?us-ascii?Q?iU8bGEDx77YyjCSTCJ/aebWWfBX9+vPGBUSkFnYxw1UYqz6QlnT5YS5bIOHl?=
 =?us-ascii?Q?LXR4An9uUG32qz1rctbILAwJyCQfttT9CPVumkW5ncdJtpvGp/2FYdZXseG1?=
 =?us-ascii?Q?X0tEVT0i1hkjytAGYBRlZy2WuSlYLkBZ7fe+Ba91tWqKNQ24sWKkpuGQFt8F?=
 =?us-ascii?Q?uCUCiN5Qt2ab3BDfex75JrsRh8khilvbrM9Ez2f0HvHz7MIbHqdD3SQgSqkW?=
 =?us-ascii?Q?bpv1wkIbhz3gx3Bo/hksknBjKFuemm0csRHRTbp/c7xs6sjzJ5dFRIrJ73iK?=
 =?us-ascii?Q?oJTLnfgOqZkW2G8h+0jz7MS3QQiAmTegC2P+au3luezm2hXk5Y9FUiI8QGNg?=
 =?us-ascii?Q?t1M2g4DPhjz+NP4kSocNFDIDH9z9+IfMgAfkECNtYNuK3+qJB6NqRo0XmnpL?=
 =?us-ascii?Q?2YjUMbn9ki/q8WZ56MeR2sLEukksMbTwUr1TL6GbrY5wnVa4Y3XrfLf69UGP?=
 =?us-ascii?Q?iVhyIsERdZ1H+ShKkOtBrWLTEhZY4i+y/BiarMj7na3oYXpAf8cFe7kscSN4?=
 =?us-ascii?Q?iOv6C2tYLpEpLA2X+ad1EMNLbrRnVYP1r/On+P+Rl6fpWuLTaQoJL7bd3Yqh?=
 =?us-ascii?Q?JcgSNWsUBCAFuCUSavUh3FZpk/VY0iD2TBalJKzzH+aYky4eRbT6Nev/z50s?=
 =?us-ascii?Q?7JZPPXCJTw8yIgKA6+uzAPj9WJ/9MyIXKgVPCsZTM/9xpLjf5xSLPPTBl6ym?=
 =?us-ascii?Q?SQ81CTyU0wKoUrZxOKPKMTb2ymwrYtnUNvutLxjHN/leTb2Lf+75cFz3YMEV?=
 =?us-ascii?Q?OI3OLTRfxpCHRc3w+xj7YibsYxHibag/e6REEe+QL9e6NC+zo0c8eI5Fhse3?=
 =?us-ascii?Q?hoq7o0CyLrfRXCSlK5CiuxuHx/TWsMxHBbpU1fCcoDMoCEw/YLCJ5HYuwEbw?=
 =?us-ascii?Q?ObYpwXQvcaXcxXONpI1W4JUgyaqRJiZdFrEtMfUjKUHEosFUEJpcTwdVbPHg?=
 =?us-ascii?Q?iKXtZxYfY1kJoS/g2IwAL9UpVMCV/GXHPNyzRzhpWS9sQFf9UUpGE4g4laMe?=
 =?us-ascii?Q?CXPDajX2cUTErcTF73x1DMr9A4m2EeiayjIC7IZ5+1riMicTOJR/O4Zw4r8J?=
 =?us-ascii?Q?mIy8LzQSN9qELJ2El1ltIspXLkpJwm+/IJMlR/470CXsSqItkm0c2cg0d/tV?=
 =?us-ascii?Q?S3FkcVrC1x7C6JBtbWqHZBmWehHzqOqCOmKDUwK3x7FasqHTMZbpKnXLc+CH?=
 =?us-ascii?Q?tBbp4mBcVcifTI92G11JRwfQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428a566e-24a2-4bbf-de63-08d8d39cac8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 23:35:13.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rV2i7YoOdSHX3y+JhM8jC+VkoXm3l7DkPctHlKz/Wmkd92fA80yEmdvPdA3aK1m6bIkDwX/+Jk4FxTBpDdtrT/gzVnZJ8rKqURAJD9GD5Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vasanth <vasanth3g@gmail.com> Sent: Wednesday, February 17, 2021 6:22=
 AM
>=20
> Signed-off-by: Vasanth Mathivanan <vasanth3g@gmail.com>
> ---
>  drivers/hv/channel.c    | 2 +-
>  drivers/hv/connection.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6fb0c76bfbf8..587234065e37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -385,7 +385,7 @@ static int create_gpadl_header(enum hv_gpadl_type typ=
e, void
> *kbuffer,
>   * @kbuffer: from kmalloc or vmalloc
>   * @size: page-size multiple
>   * @send_offset: the offset (in bytes) where the send ring buffer starts=
,
> - * 		 should be 0 for BUFFER type gpadl
> + *              should be 0 for BUFFER type gpadl
>   * @gpadl_handle: some funky thing
>   */
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a..3760cbb6ffaf 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -28,7 +28,7 @@ struct vmbus_connection vmbus_connection =3D {
>  	.conn_state		=3D DISCONNECTED,
>  	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
>=20
> -	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
> +	.ready_for_suspend_event =3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_suspend_event),
>  	.ready_for_resume_event	=3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_resume_event),
> --
> 2.25.1

Vasanth -- your changes to fix the spacing look OK to me.  However,
the Subject of the patch email is a bit unexpected, as the code
under drivers/hv is not a "Staging" driver.   "Staging" drivers are
drivers under the pathname drivers/staging that have not been
fully accepted into the Linux kernel.

Changes to the code in the "hv" directory usually have a "Subject" line
that is prefixed with "Drivers: hv:" or "Drivers: hv: vmbus: ".   For this
code, you can see the history of changes and the Subject lines at this URL:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/driv=
ers/hv

Also, your submission does not have a commit message.  While the
Subject captures the details of your change, the expectation is that
patches should also have a commit message, though in this case they
might be very similar.  I would suggest shortening the Subject, and
then providing just a little bit more detail in the commit message.

Michael

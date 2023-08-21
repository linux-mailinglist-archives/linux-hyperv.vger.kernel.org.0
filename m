Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C578247F
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Aug 2023 09:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjHUHgi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Aug 2023 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjHUHgh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Aug 2023 03:36:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBDB6;
        Mon, 21 Aug 2023 00:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYCCpjsN/sRAA3+75p+QyuwuneR6U6wFKy+lPhr5nd1kjcO2ZYEX4iW7SCe3o5u+pbvuyoE2EEQe/chGKo2sZTTtB89hGdTG3hUg9uhVArpTxY5UEiXJreCX4aEKyT19GQcAG++zx406Tc7Kkj95ylqJLt6lKRgcLeJqjCOz4lo9Va7SrzAhfWHVKY4vfpSkYubvgd0mkAnuUsgMszmEssHBotAtAx42GtOE2Teed6KwZ4H+YKhPl4QqPvL2vsMNf+Nsfpdtk+ZKyezjtMUX/Pg11Ay2mjhAPSDKLIHnSNjWs0FksIJaKAJQ2zGWjVU7pXpEW23NTock9rmTtSRjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skQoce6Hm3hoQF3neQZoRz9HZpVj0M61zBJ9fhYen9Q=;
 b=avFxUbXlEPABcwdG3Mvj3Oq7ZLPXq48+iQX6ZEIwkW3HSISvsnZpOS/6DDKoCCc57lgWf3zmzBeSv6ByiAlhe+ao0nadypcYc/thsZLs/eDCDMW0n0MV4Bj3HwD1jo3SwhzkNO2F3zH9AmkxIUmKdL08/QKeMJT8M8dWC9z5c9GlOXCd4eHKoQc4wVU3p3WYUwKknLqlTze99rBcx3gUr7Nm0PGyiWsG1Jwtw11QbpP7FztW4Oh605PbFhBxLiO1vihOb5VQN+pK7yZ1r5uX3v9+E45utDv6zoOx/22dcdaAvkHQfGLDfVXJHgMVLIslO7pvgY07OR36gNL7Yle+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skQoce6Hm3hoQF3neQZoRz9HZpVj0M61zBJ9fhYen9Q=;
 b=ikmdfm8xNLGRwL/oKk8a7j8W6/LcHP9bbSRflwWkC5STBjOXwar9tXEaXPFWbVPgksILAuyOOtv9kAaSP8ua3mBNr4brp+0OspJCooi8njvBA0oD87603Z2yuZGX0Z5NBUZP1xWV8M2GTzXeZ3GqlPoPamP3YMcdpYagwwN+j3g=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 TYZP153MB0708.APCP153.PROD.OUTLOOK.COM (2603:1096:400:25d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.3; Mon, 21 Aug 2023 07:36:19 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 07:36:19 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
 devices
Thread-Topic: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
 devices
Thread-Index: AQHZzQ47vx3DUWcUp0iTgoNoEQTxQ6/0YcnQ
Date:   Mon, 21 Aug 2023 07:36:18 +0000
Message-ID: <PUZP153MB06350DAEA2384B996519E07EBE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
 <2023081215-canine-fragile-0a69@gregkh>
In-Reply-To: <2023081215-canine-fragile-0a69@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f06dd1f-1163-4dc2-bbb0-c7883dfbb8a3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T07:06:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|TYZP153MB0708:EE_
x-ms-office365-filtering-correlation-id: a2480395-6ab4-4bbc-8716-08dba2194eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: paEhOJKMJ/SSHyOCpCWBruclO6BeyFlV+mOtVrfL2vk9fTPlgS4ALRSTldY316NhIQErQtlWbVdnIwEe2UYDYjPy1rgACgXObGfgMSmQR63o8rOoJ03lJ1vZHcB94sdeVW1wHS0Nw5QIs9AVK5JKBx+5IUoPtAHSCacFX3Zs2yYhF1b58dKlR70RKJkU+f5lz9AC2v7nnhuPEBOzRLt+1VufDgXPi0lgem7+jy0SK1658PFG7COoqcIDPJxK5hGGYqQzPg16lDkPIOpk8vNJtxhQKMtYvGuIak/qs/y8GFeiDpldNv6oGdiDC+2pQ/Y2v06tbNXqeGUf8F0K0xbiWKJlUP1jA46vMWTzcC+Fgk1SZiuH0rv4OAJ0AwylSM4StD14eiVOMXLihgAXjuvT8IZK5zR6pPuhFmY4UQXvxXT08PzcxgVn1qg0t5JPIlOQ+glBT5hPgGsPTWIdHhNKdFuNikBhou1gqLAqRvH0Hh+163g/v0Ek7trhXGqBvb3+BGr44lpRFzQuM6FsC9py/LIAWRAv+2SlObdlthVOjRqxwlFERgO8iaL1a7Uw5J3naATzdMTK/nMztFKQVvtnVF0cDUdY76aHI+5p/xhy+MxwukiSzhVIjT2k2K3NwjAYyOYAlXUEDGQOUOFZk2oQB90L9xpN6Zkw1PZoythXSSZOmvxI1RICzKAGHZfr6l9wuL+UNF2Z79cUESLwEAmixw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(1800799009)(186009)(451199024)(8990500004)(9686003)(71200400001)(2906002)(6506007)(7696005)(55016003)(53546011)(86362001)(122000001)(38070700005)(38100700002)(76116006)(110136005)(66556008)(66476007)(316002)(54906003)(64756008)(66446008)(82960400001)(66946007)(41300700001)(478600001)(8936002)(8676002)(82950400001)(4326008)(33656002)(5660300002)(52536014)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sBW0t/avYZDn7CuJIccRN9Ihvai96xCy6ifpCbUaWsry/gNrbRyHvKe2d8Tx?=
 =?us-ascii?Q?w87r63EwhQIoMhbqOJaMSaoZVmOl/RnctE0xY94zYY5LPZngKPKDeyj4nz3r?=
 =?us-ascii?Q?D0ydOqGbzJ9icBm8iCU0asxcneU/fyEOOb8X6iAWr7ubZA5lMj521EEn/5sQ?=
 =?us-ascii?Q?rAXH11H3YlzlY0QAzLLNmiqh5s7hW+pZMxFCjxXQ5hi6+o2HWQFvyBVntaED?=
 =?us-ascii?Q?3qAn/8H/2YftEMUIh891rAhUeMeSDeZRPX6R9wNbVKxnnAtFDj58sT81mjz4?=
 =?us-ascii?Q?ZAlgqjaYStB/EEGSggNACzYLrR6WVF1+c6G/FFWJba6xyvCFddDVCXyIAC7u?=
 =?us-ascii?Q?J1S4nXovfLRX6sxHgr6eTwfBEB2N0igvL7JVb+H/+KFUUV9G52v7uUGggYdt?=
 =?us-ascii?Q?oy/+4uXfUjsL6316lWTG9ZwXq0MRKH4Vow9GT7dblpPI2wIaggVx0CZBj8Et?=
 =?us-ascii?Q?kncanh+ONwxmcZZViW/E9ww/9nx0xD21cov15PK0ea6fB8haHd9JCPsyLIiM?=
 =?us-ascii?Q?WsiOUnA1vksuYk/37o/RYwJN6zXmcTQ6dMrkb7vmDv//VsC9szyRjzL63jrp?=
 =?us-ascii?Q?81nzvv5p6joTBRJK/tEbu9yLNyVKDO40rpRfyDN47x3ZguA5bQEqhYewtIot?=
 =?us-ascii?Q?ajd+kkC67p3bfAtIvPbc/L8WgK3tysk1oFrgMVhDrk4ZV7118syMnLQJ2tZD?=
 =?us-ascii?Q?VOKpPIMOe/FwFmNYEHEuuGnGZ33M4B3GlxMPSmXj3OVNKTRteqW4QIDzfUuk?=
 =?us-ascii?Q?Y7eJ5zvYC/VU5G2t9tOSqa71QxWLlvgqovwsQNn8yvHt1cpsoyOJ5nebIaoP?=
 =?us-ascii?Q?zCOMMTGidufx+vGbgXd6ETDLtdISxNIYFcRZAm0srjEpy0IvVW6Vlp6m7cyn?=
 =?us-ascii?Q?O536kBPWmBzroaDPfLcpBkJ2vnOuSQ+VIeOWmo9iQBGEMglRdJv2pw7eHZXb?=
 =?us-ascii?Q?FKjdaCn6zbFwvc+Xb4eB3bolgGCN01bm8SLalJ3BN7iZTQrlyEWZ6PwrzFnq?=
 =?us-ascii?Q?Cj9oT3IlI+feT5CTsr3pJVL9rPC9NKY7TiJh5FnJKyTgBuSK2OmQ8L4MM5wd?=
 =?us-ascii?Q?zeJID3Nk8G6mtgTa35dc4h2EMDrZec4DB0+Xc3LBf1ydoAGm2kCIqjo0c66Z?=
 =?us-ascii?Q?Ovl1MyUx9GAEfXXLEHTTgVApc+N+3hsi/RO6abxYs/WqYdCFp1mqS6KuWWhF?=
 =?us-ascii?Q?MfmVHZx1VAH/hmRbcY09ipYI13UuguBWx1LtHVwWhTIr2Tt685J0Zsw5FIYS?=
 =?us-ascii?Q?Mmqsun3HK7MEklnFKjq7ofybdmG5nlFE5DZAfg2yxB1uMxa7nKL1XjHgp0qP?=
 =?us-ascii?Q?M41+io9T8ASdmzwa6TRGjNvuL737j5l2KZkk8cMzCS7quINhOnl1KbCn2MLb?=
 =?us-ascii?Q?jXed91UZZrcJvtqiLVz9iT00lT7/JXcKM9RLM2EZtNkIky2q8QxiMHr5YTNg?=
 =?us-ascii?Q?WEWRalBrYLU3h6aFLOUQctoqBT7uWldOHbuid98AMqendJVo4IqmCFHZgmVi?=
 =?us-ascii?Q?i/B8kyvxTve83jJ/pfGavidnuQGoo6o8FwmEpI1r/61jX34im8kWVCXTN6yi?=
 =?us-ascii?Q?mJx6gkxKbEifsOP5Q6pbhcqAUFzXgqC4AKqOF0Xc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2480395-6ab4-4bbc-8716-08dba2194eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 07:36:18.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXuZoDYwIUQ0JgnwXuO7HhJmXiC57Ee5XfwjM2Hk3B/32GkiH8HW99FBWtfifHFJwfGCcR4KP/bdtpJwkaSdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0708
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, August 12, 2023 4:45 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
> devices
>=20
> On Fri, Aug 04, 2023 at 12:09:53AM -0700, Saurabh Sengar wrote:
> > Hyper-V is adding multiple low speed "speciality" synthetic devices.
> > Instead of writing a new kernel-level VMBus driver for each device,
> > make the devices accessible to user space through a UIO-based
> > hv_vmbus_client driver. Each device can then be supported by a user
> > space driver. This approach optimizes the development process and
> > provides flexibility to user space applications to control the key
> > interactions with the VMBus ring buffer.
>=20
> Why is it faster to write userspace drivers here?  Where are those new dr=
ivers,
> and why can't they be proper kernel drivers?  Are all hyper-v drivers goi=
ng to
> move to userspace now?

Hi Greg,

You are correct; it isn't faster. However, the developers working on these =
userspace
drivers can concentrate entirely on the business logic of these devices. Th=
e more
intricate aspects of the kernel, such as interrupt management and host comm=
unication,
can be encapsulated within the uio driver.

The quantity of Hyper-V devices is substantial, and their numbers are consi=
stently
increasing. Presently, all of these drivers are in a development/planning p=
hase and
rely significantly on the acceptance of this UIO driver as a prerequisite.

Not all hyper-v drivers will move to userspace, but many a new slow Hyperv-=
V
devices will use this framework and will avoid introducing a new kernel dri=
ver. We
will also plan to remove some of the existing drivers like kvp/vss.

>=20
> > The new synthetic devices are low speed devices that don't support
> > VMBus monitor bits, and so they must use vmbus_setevent() to notify
> > the host of ring buffer updates. The new driver provides this
> > functionality along with a configurable ring buffer size.
> >
> > Moreover, this series of patches incorporates an update to the fcopy
> > application, enabling it to seamlessly utilize the new interface. The
> > older fcopy driver and application will be phased out gradually.
> > Development of other similar userspace drivers is still underway.
> >
> > Moreover, this patch series adds a new implementation of the fcopy
> > application that uses the new UIO driver. The older fcopy driver and
> > application will be phased out gradually. Development of other similar
> > userspace drivers is still underway.
>=20
> You are adding a new user api with the "ring buffer" size api, which is o=
dd for
> normal UIO drivers as that's not something that UIO was designed for.
>=20
> Why not just make you own generic type uiofs type kernel api if you reall=
y
> want to do all of this type of thing in userspace instead of in the kerne=
l?

Could you please elaborate more on this suggestion. I couldn't understand i=
t
completely.

>=20
> And finally, if this is going to replace the fcopy driver, then it should=
 be part of
> this series as well, removing it to show that you really mean it when you=
 say it
> will be deleted, otherwise we all know that will never happen.

I was hesitant about disrupting the backward compatibility, but I suppose I=
 could
rename the new fcopy daemon to match the old one.

If this series has no other concern, I'll eliminate the current "fcopy" use=
rspace
daemon and driver in the next version.

>=20
> thanks,
>=20
> greg k-h

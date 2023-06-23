Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14A73AED2
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jun 2023 05:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFWDAM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFWDAL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 23:00:11 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1C211E;
        Thu, 22 Jun 2023 20:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTqXip7NTvvkzAnXcn9MAuIiYXW4Oj0REkeZNV8IKof8f823HrAnF0hwkw5V4xZlMny4wmSdhpJdhXFu7iYdWVCuGpoKQQeSGsROJfYHtBq243sLlaQtr+zVDvdN45xUcbxuCnaqKBWeGqk8DUSGB6aYQ3cNacP7zE3MDs1Va7BZVf01fHQtdAqPmIxVxlC8/ziuXtyB7OnzMuYTPiE0y6ud5vIat1uibuFXvfwWeHkFO2e0z3iVtPf5FBBunxP4JpdBbnZt8aaTMZcMAgl0dEGstGctRQEdUdT5jalOtjdZDYeV7TEmIPDOVVkixMPGFknIgdtnyN2OTxNxPZKYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOZ7JLWaDbXMhfiLhVZrAuEpufgNg8g5zha86jwc384=;
 b=XJMArh/fKukhhGDeL6ER+D7khBCBkK6zrobvTVbap1qSSZGsnYkKSOQd/Ws1UAhYaa77Lm5rLVoN6DL15P/tf+JaLkhIbewVmAiiQWbvmlbtUCVawCZqwj5KNA+meu6jmwKYaqZnGKMxOMdy84zSF35o1BD/KybS3zQvZ2ilD0x9VfuzBgMM2hevN7jZ5a7E/qPVokWFgIwLCSov2Xe2VT/k+1I1JzbOXgnfb8xSvkQIe0Ezg8dVG5YvrNBU806egyDocKB/FebKpAdQhwnkYoJe0F17cjyytm7C9p1GK5wYXzHyxvnde80Db5wmrL0BetQ+2ChUbGf7PZKh0LjRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOZ7JLWaDbXMhfiLhVZrAuEpufgNg8g5zha86jwc384=;
 b=RGAI9982TXwMxZU+QbFyKAfsXuMQzJAbXD76fbtLbvqRe8KnI2GpnfUfNdCIVO5uPerV0RnD9hHfgyD1lPRHDC5IkVouxzsHIqG4kSyjI3mld/Spi+ylsuE9jgLAX+XWSIY2g9wdP3MsDHPeRJBERgpuY8BVkrpXsSkqoZeDZik=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1958.namprd21.prod.outlook.com (2603:10b6:510:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9; Fri, 23 Jun
 2023 03:00:07 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.008; Fri, 23 Jun 2023
 03:00:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZpSXIMoXo+dT7t0ST/0M/X/rooa+Xsx2w
Date:   Fri, 23 Jun 2023 03:00:05 +0000
Message-ID: <SA1PR21MB1335868E1DB4D651A62814B4BF23A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=31544dbd-76fb-4673-91f9-b02eb5e796fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-23T02:59:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1958:EE_
x-ms-office365-filtering-correlation-id: 85fb9b61-baf6-4819-0317-08db7395f26a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGkW52gPF0rk90u0ivenk5TrADN2CUE8JghtW1H6kUiXjVHMyp7q+M3nRrD3fYfuLYPwYqoMe/wUuvOqR+z8Tnb9ptgT/gC+1b0WIttEJkOq9QVOg4bpa1yQc1/jgLAm1omUCQPlNwdKRHPUBYX9kT7EnbJku/j3TNKCpvS3nKDGizJvYL45Nmcqe60PXrw4uuxMeigIFBuANmXSJi9YC4XJmsBiZBCPJbDozvooES1xsIaTVQcVcXiGvtIp7rZXJsaPJ7J/C4/y8U3phvMdF7TQPFqsHJJxyiQvbVkd4Nt8Itvzpuj/EYNQil4/CRrwpK9027B5zsWIw2uNLplH6e7/vnhscjPI4KyM59klQGLHjeKq6x8T3cdE6L2pch0Yysnx6fGfNJAFw+SK+qvYoq/J3ZVWyPMyPlTfJxK9nHZIWLAPTBZNfjfUIKaTdq25aNLlrthVzG0CwLgb4dIhDMJHw7F9hv/BD03MPPEj1tqMGf70PCCrbe170E9mSPC0cZH1p64vwGlJkDVzsC2y9h1XDgundF3NMdh6V8pj00BBRU2X7bg3yxmsolfwS7fpsn3pNPV4GNwcOTWWFZEZDXL8yahrUx4UFuv1tb5PgTvuz+iLH1xcZFi7v9gLc1eWSJaRsTLfiDYerldhcdFr35K14CP8c3qOs0S3oLkwG0ubaIFdolUQMkKmUvdoECeN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(316002)(66556008)(66946007)(64756008)(66476007)(66446008)(33656002)(8936002)(8676002)(4326008)(478600001)(38070700005)(5660300002)(76116006)(52536014)(7416002)(10290500003)(4744005)(2906002)(86362001)(55016003)(110136005)(8990500004)(54906003)(41300700001)(7696005)(38100700002)(186003)(9686003)(6506007)(82960400001)(82950400001)(71200400001)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cwc9wKx9eXND1qbec3F8C3OmzTB1NH9sjdCA+Hhnz/pbt1SKSG0RJEx7tKWd?=
 =?us-ascii?Q?DV3scJ4G37iOw4yexUh2BudI5zCsLaPasR/94nAjYAA4olMDLbWInxQvgHZx?=
 =?us-ascii?Q?6k4oT1m5ba9VCbBw2TcYSfG3yVa2GHZQYo7z8GY3qW6HlgDhZdSwj3Y1JWhl?=
 =?us-ascii?Q?vxaZV6k9pSrUwucrZ2o+n28jAks0jUjIsqYYnOEmENc5u8Bw/nVaxm68fj9c?=
 =?us-ascii?Q?bpDVgf3FRDQ29ePXppBfTZIP40IWSXUYiZqFOsvtk+prq62Wnif9k5Oev+cc?=
 =?us-ascii?Q?e5r/H6QnBLFoIKU5kFdrVnIROJR+fqATJWRznZhM58DGqX82LQqid9UG2OPa?=
 =?us-ascii?Q?XUyjuLTA+y9lhy8LNsyuv+6VubEFfOS59bS23xrqN4Mgwnwe+W1dWdi42bZu?=
 =?us-ascii?Q?AubzijyKCsFUmwFdEvk3Eumww22JOL4kwhBAf0xPzxqh1bNzOD+HcdlKIvCb?=
 =?us-ascii?Q?N8vMhkvF510V1YD5xUbBo1RN6M9616WpVwRW0BPFgCRd2Mlaz4sBBEZxY88S?=
 =?us-ascii?Q?DJtGEzQnu75Ej1he8sqrSB102WV9pq4UvbSxYNBXh3c7gRbjXl15TgMXMshk?=
 =?us-ascii?Q?zXbsTnci+T5geNSwwqo5vA72mrzfuXw4eYsL/Y1ZRpzUvZ9XVsVvDHGPP4QY?=
 =?us-ascii?Q?pC1eQl8b3NPpAzP7omya4HBBdrSPslLism6aXLE3H1dPWreRo1o47THe+JUI?=
 =?us-ascii?Q?a1JBvMB1bBxnu8Pi+s0DdURTj+Qbew21usWrlieexxEt25EgSdxzS4WRo6RT?=
 =?us-ascii?Q?2CPlAvdjQARJ1kuTzcJDLOeSey7DSD1LEcC3gA6fKBzIabM1ireBhhPAW8tM?=
 =?us-ascii?Q?ry5s2LIjP2uVsEsoWL4kPQ4TMyZMsHYQL920ypMr7Ppombrv47m0ojMW9yVX?=
 =?us-ascii?Q?b/R6fWPNON+xn534lbPlqXDfOJTp2om6YxkNKMystR6r/ygDCDTA/UVvCJqe?=
 =?us-ascii?Q?Cjuhoii1wAqCrOwlWiDMb3fpRIncNlCierKx6SQ2xke3jH6Ybwu9VtvxKpsf?=
 =?us-ascii?Q?eTeASvL42IR7ttbUQOq4Rtpkxl1n1+lng9a6l9EGFsjsjS08B/kNurQpdWPa?=
 =?us-ascii?Q?uQWTmu0rXUMr2Q3eMMlRlTnH7LbSGChiH58JEaoPr5iW3JSonNr8onNYH3z7?=
 =?us-ascii?Q?i7nipPmuZeeCcLm92pJLow9VgNvp3H2aVpkPR8I8BLG7mDYBFdejaixtU8D5?=
 =?us-ascii?Q?TIwhMtlmK/WKY5KFDUMXdGKXMuyl9tEXkGxOAyROH5uVsLbubXXnS5w+DudQ?=
 =?us-ascii?Q?Cc6BgCODEWRqGjKi8wJ9JUjfU5KT333a0dJMYr/premUgAg5/rU1jOR2zHgV?=
 =?us-ascii?Q?bE0gNqYKxtQibyVFdptNzOKqb7SNuVY/AQj3/4tuH+X11Mmecl/f8DVgUCue?=
 =?us-ascii?Q?DfiZLJLHTRte/XSkyqCLX41EbNXJ4wT+IFzrXIKdcD2uoABaGGIU4HNDfq4b?=
 =?us-ascii?Q?b69w22Tbj3KG3ZJXHpNprTcK/sJdGE97SJkZH/h2WqCeF1zU7pGKiJECjMx5?=
 =?us-ascii?Q?bb9wVHVaSWqAv/8mUbewOGrUQo/fh2ScypO2zF/JoNCX9MDRC/AZdvOZJR86?=
 =?us-ascii?Q?+PPqD+n+9JKKDBOEoyn6C88USnY90C/nk+mkO8DTYvS2e2S4i9mkrUvC91a8?=
 =?us-ascii?Q?nRKxzzSv7wSnd9Ghgrh0Slc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb9b61-baf6-4819-0317-08db7395f26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 03:00:05.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYYu+6BsIql3RhqHAZBarCOQD7JAGvo/QYpBXK502hQpbqXouGu7gEmHwPDDyMDAznux/pyRqp6lYi8T6JdUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1958
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: longli@linuxonhyperv.com
> Sent: Thursday, June 22, 2023 9:23 AM
>  ...
>=20
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue.
>=20
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
>=20
> Tests showed no regression in network latency benchmarks.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

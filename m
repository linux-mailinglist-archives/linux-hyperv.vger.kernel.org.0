Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B456549FC3D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 15:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiA1O5a (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 09:57:30 -0500
Received: from mail-eus2azon11021014.outbound.protection.outlook.com ([52.101.57.14]:45411
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245578AbiA1O52 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 09:57:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZMEc1nBrKqiSkdfClUsjOZENDMOVEhJjKGpxoavswCRQ5FblXPoB0Qkx+HU7Gvc2eQyPeGY+cKrxEI5qpwSQQ40mBkQA/t/dag1Z3OGSYceznigf24Mx2z9uyEMGUL5XfaSYurFO0ERCMvQJ1FimnlzFFol4QKhSgWMhnq0Y0jDvtsmESz7CG36DmYBzeCIPOta5+iWfVUFuAKzwyOETZUYMzurDWmOoi4PR44UCzJRvp4oYCBNE8XVPlio1bPmi/M7jkh0TSaEPNDdXND1R++3fOte+MS9Z6mT6K9UdjgnfX1prpq9WTKHAjoQmjBqNgAnSIwVgfYhaZ4FrdaL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzF9HtyMfBILHaAsgVvuPV7AmWV0nZ5CqB+/hRYv5ac=;
 b=YInKc0tFor8+erRWUc0PXhcb8D6phMojuuK9V6xjkOmfQOId+j+fKoDQUHRvKFKvknrVV+1PyF4QyqwcEqGRmyUc1QhU9YHGZQC59RLMa3hbkDph0VbFm633g46aQZe2LOwzcYADdodSWTtWhnEziUyU8zPEz0iiC6XYhxP8RC8DGi/IcWaLlRzSwFJ7FNGsxtUxZ6DNUiAvY7Ap48ouKCZBI0ojXSCvxW2BbXvRHlJBNw745/6CJF0/CQhzj3jYH4gOa/1C4XLKlCAzQ1165kbDxz3CThDJHjZe5w3bU3hbeRBaHT6c20hALoZY55/5KMF9JGxKp5lg8AiLJBKT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzF9HtyMfBILHaAsgVvuPV7AmWV0nZ5CqB+/hRYv5ac=;
 b=TU1s4YIpu8FlXE6maXMQIoaLNtoI8PPVeSUG3ona46nvF5pEKiEJeWcAgo5PhuWy9ADnarkVTuWZONkAh4pABQbsMPiVox1o5ulies6Pzm5O9QcCQpStKsIDStzv/NB4kxA596CPzK7mqODhIKrWlC4pJRb5cf4RyT6QOJcAcLc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR21MB2111.namprd21.prod.outlook.com (2603:10b6:3:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 14:57:23 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 14:57:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: Compare cpumasks and not their weights
 in init_vp_index()
Thread-Topic: [PATCH 2/2] Drivers: hv: Compare cpumasks and not their weights
 in init_vp_index()
Thread-Index: AQHYFDKhRI5fiBmXrkyS3HE6hGtFlax4he+A
Date:   Fri, 28 Jan 2022 14:57:23 +0000
Message-ID: <MWHPR21MB1593EB66675B0EF8ADA3F580D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220128103412.3033736-1-vkuznets@redhat.com>
 <20220128103412.3033736-3-vkuznets@redhat.com>
In-Reply-To: <20220128103412.3033736-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89c05ee3-f8ea-49f2-8dc8-f71da181a876;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-28T14:56:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2c80ec7-ac8d-4d6f-e1fe-08d9e26e7e0d
x-ms-traffictypediagnostic: DM5PR21MB2111:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB2111192A86CDCE42DBAE7278D7229@DM5PR21MB2111.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7gdMwInD3AH2ejHfCHrW7H+eQBJ0awRWTGJ7vhGLzWYYm14rDpnbj6nagxFGkBMK9B/gi5U7aXB45IL6y/YPlTf3axQz7DdJWJY2okId1dEx4Cks1qIzI2DwvPFU+/D6DZ8fgLJbg6+Kv/mYpSCggm+OarSNXYScgtd4H1t7EseprweSlTXSrIEdx5PL5KNuVIDW+RaKtDunQvNjuVvQZlU+zyfTzdhskxoytB64PYW3sDRuftWW/dzHd2NBO99OXOTbE1xBES60gfxXVTD5qXWIml82+Idid0jmyewwE4XYF3XNjBDNrVrGGPRgHsx5g5/MlbUU5W4AP6Qhym2FUzSMbeD3Gya5RM/M6kg6OadT1fFkEAAwyUxixiCddLkuKT3Lk5turbRrNUbFmI7I9BXAIomfBMzQUknxRERDKogCinjv0SvcJb05ypvapDXuoswn6Ebj+8DvOt8MjRMgsY2NZUcOkQpDJyXf26TYhTuhc0qZUZIeOqhWP7peVUW18nEVSFvfc6IaQNAYR2m9cDaYDi2bnYd//3k/9v6Wx0sODqgz8icjHSUkQBswlC+lQdXiA0N2HKYtMumsFQyBR52AIaZs3Sy7Y0uuF2xYB/a/cEK0wS5CUCtA43OnevZ4n/Yt0vHfgfgBZknik+CGwHPf0NX8A5FmMVqKla0L+M3IZWm4rB8mlSvrEcC4YkU8pJJoH1b4IZYCdcAkZDzvEWv0ad54M+1WQsW18Ymo/6znV6n/sUTWrrRh25Z9d8Pmn1cOLtXgje1MHV34iVNCWI8X/pcQezXF+k4jJAAIII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(7696005)(6506007)(316002)(71200400001)(10290500003)(54906003)(110136005)(33656002)(55016003)(66446008)(66556008)(66476007)(66946007)(8936002)(64756008)(4326008)(8676002)(76116006)(5660300002)(86362001)(82950400001)(2906002)(38070700005)(26005)(186003)(38100700002)(107886003)(122000001)(82960400001)(8990500004)(52536014)(83380400001)(16393002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8p5Hcz5gF952CO0M7eLPExJhcLqNWX+0DQswAYUfud7iHFJbRlkp9oc9IOrW?=
 =?us-ascii?Q?E/i9MgtpV89LeKXHahZLC88PGd5/YW6O+wlRTUaO5rFciyQYIPcTnhgdfd+N?=
 =?us-ascii?Q?lx6Fzz7+PQd2Idig7TjQFXnKgnsmZ+Y+LKLopxAnEV1gGPUfs8gN6scqBKUh?=
 =?us-ascii?Q?vSqRu66lEhGsInZRLlCif9wIleDvW+/coHM47A/26kj96CGNOrvCXlK2yNcF?=
 =?us-ascii?Q?lIrEmtaLh5vBEDQ/s/6GG35gEBermQahHReDlRqj8SZkd22jyxiHVlHneHL2?=
 =?us-ascii?Q?7nFHi/HwTcItezb/f9EzVLQQeDbmPcBtD2gAFiM0+yqQZUp6A/o0pjzeGj+q?=
 =?us-ascii?Q?lWNhNbqpR3VV4TiSsomoHtz08yBqBaYXiyZFFZsqLe3jzDX2UOck+tQHwWOX?=
 =?us-ascii?Q?rIQNqmBkVWSqmS0lQ1SKaoMoMPOG2M3cUMBk47v8/O5tGBMR3yka1uYs0JWB?=
 =?us-ascii?Q?jVWniKEm2I8HBoQ5yibL8C2D2xwfIR9jUXCogBCiA/O5mHpZ3k0Ea0Q5kzO5?=
 =?us-ascii?Q?cBBGKObHavSBNFja1c8YPB6+azqyBddOUyrxO7zaft8GpZ5pNBGsCbgFFscR?=
 =?us-ascii?Q?eQD2EtID4DyrWRqLQucGAOheDHOkNHUSCjfB1my8tF8WE/aDeKZ8lLIpetTV?=
 =?us-ascii?Q?5RhvvHsEpF7rnIhP4fhnLfvg2rGKWTUOvqXiWTUB6TBLKlzUbYAkoeeUPG0f?=
 =?us-ascii?Q?HyGBiicsiu+zp3frvGIpVxAVJuQApKa2uvD+UwwXDaCL62p6xvZ8ItLaZ45O?=
 =?us-ascii?Q?TCiNZkygHPT70f3hSqP2qX7Re3crxOJU8ox9DewywfBNsuQlE9+ZHiQ0VPF+?=
 =?us-ascii?Q?5S7fPtlO9XuooxB46t2ozplvvRq8D0E4Z2dEXktrVxCfsJu5PP+B/BYZDH8f?=
 =?us-ascii?Q?zzOVGx+/r0FQtn3VoMqgVeoDsrlnU9iQ+aeqyb6OF3G58SgIgWRq8rHeyOVu?=
 =?us-ascii?Q?RYD6ARqUykYFPmkoWIyO3x9kblr/QoDv8Ta1uIvoTP0RnIHHL64nqhHF4WfZ?=
 =?us-ascii?Q?4f3WPw4R46HswoORwBsKX0NrLEdD0kFLOFIO+TtFmQ/HH4NNHr3Z2uVPHS/e?=
 =?us-ascii?Q?LXu/C4563iw9F3MuS1N7wj8EDYJi+5no4O+tBJ7idAlX9mKonxmrRWS9tB6k?=
 =?us-ascii?Q?Tt9ah7vRe8lH7d4fnSTwVLfPQiQbpOUZqRhn0pS15N+65HyMDQdVBRgHuuS7?=
 =?us-ascii?Q?dT+6GdDsWKa+gGBxPLXJyQXY85qmPO3XmP5TARIoeFhSmePBBS1eShPgRqr8?=
 =?us-ascii?Q?w8MQlF4WoyaLtngO44IL/6kSbWJr8f/p6vdMx1b7Je+kRgDc7dWlpDAWbfta?=
 =?us-ascii?Q?bHTshRJiS8tgcwalup9gqoQo+gFjq8N2FSsR7WUQ0b8aisWmI7nitM/Sva+3?=
 =?us-ascii?Q?2r4LiS97uNokt0Pslwls7KWsvh0WqaJGPoOehZn3t6NHnf1yoMoFranm4l19?=
 =?us-ascii?Q?a8MwykMgTCMobNmP/7tw9auK3s1T1/Wd5boTwmE8HXMF015Ncfd6A7opN1tO?=
 =?us-ascii?Q?Q6HlKHlA5GdQm9ukMUZWyx1sL3ra6tmExT9RaFbtJs5JEHZDAs3uJsIKEe7q?=
 =?us-ascii?Q?C03QqNzDfc86RWfcKoFb6AbU2MnrQSyx6T4WBxnLpNSh5r1JeQY3o5ahcuB/?=
 =?us-ascii?Q?oKVi1edfn0qie7s7AWBLGMIkfNoCY3qfhP6L0iuQT4lARXn7TTT+eShn2VeJ?=
 =?us-ascii?Q?TWJ6EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c80ec7-ac8d-4d6f-e1fe-08d9e26e7e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:57:23.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0KFIB1OaVSGJ/R0G1X/Qy9OHC4lRTqk461PZNzj4VX4GO0XbzHMa6e8XHFtTIWXQ9+nRtUBE/vW1xa+qHOWEGtD3QwQnDl60RSPlT8tru8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB2111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 28, 2022=
 2:34 AM
>=20
> The condition is supposed to check whether 'allocated_mask' got fully
> exhausted, i.e. there's no free CPU on the NUMA node left so we have
> to use one of the already used CPUs. As only bits which correspond
> to CPUs from 'cpumask_of_node(numa_node)' get set in 'allocated_mask',
> checking for the equal weights is technically correct but not obvious.
> Let's compare cpumasks directly.
>=20
> No functional change intended.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 52cf6ae525e9..26d269ba947c 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -762,8 +762,7 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  		}
>  		allocated_mask =3D &hv_context.hv_numa_map[numa_node];
>=20
> -		if (cpumask_weight(allocated_mask) =3D=3D
> -		    cpumask_weight(cpumask_of_node(numa_node))) {
> +		if (cpumask_equal(allocated_mask, cpumask_of_node(numa_node)))
> {
>  			/*
>  			 * We have cycled through all the CPUs in the node;
>  			 * reset the allocated map.
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


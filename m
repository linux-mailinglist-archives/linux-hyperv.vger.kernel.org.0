Return-Path: <linux-hyperv+bounces-1482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A15842D88
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 21:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26879289870
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4171B3D;
	Tue, 30 Jan 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZuwS+t4W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1F71B34;
	Tue, 30 Jan 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645606; cv=fail; b=eSlDjzOp5WFKobrRWmfAIJ2j0Go3q8xvuw6JzOcOU7SGwAxckDlpqItJshFBkCHfMBf2OiAM8IpQ5HF9tA4AmqOfiertTADccbiimvPKPVh1I5CML6MSAV98EOemzYb/H9JZnBufKrKX2a6mqgtAlLREg1sVfkA+YbBcxySK67E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645606; c=relaxed/simple;
	bh=AULLZhCRHkkVKrSvDX3AH7+0zbY2g7qyw+zizy/he6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tkNHkLfogQmseEEIeRPySNNkvzlR0vXnR/8dMozjjtB0iVamUegMWrasMsGFsnQlhYTYJ9NUkl5NOiTgrCuCcPzUEkUfxwsiNDoH0/FPqXYKf3uM4Bdw46tjLSnkFaYbUJtnZXkvHp7buJhvAwnx8IuAzweOrwfLyf1YEFZ/Rfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZuwS+t4W; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezMXLheCwbyiCwOTjoAx7L6p0tBgOy2nUIXfkT5d8HhIRGiI7ewdiYyWVSfJwpL4BWVO7aUa5EZe4sgQcl054L+SWhnzcKLDj7gJEpVzF2g4oBHViYLPNqmsLWd3VidTkxteW9mVMdKjKfEwT3vmkscwC0MPxYpQUgv2Guhnj9d3HyiVVVX2hk8BtK61lenME662ACSax6cVQbbj5HCNu2tMwDb5ca2NHNc6fp6OsOaG+Z/twmszVg191vGcDlNhPXe5FKL8RbNjOQcgq1jh7njBcAXODUo/WPP1jGnUB/Fhx77VszeicRNWgdYvjiIrKQLitgBKGQj1Mc1tnDtCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv3/sgFIpLkJFvF9I39vYkQvhh2UyQHO+UI8athqv88=;
 b=lnjS2wy8AcQzB0Ls3DBr7UlIovbQBAmpiNG7vV8wrF8FfvUr2pa5UtoHoTWU9kisVoQ6X7qFVO8xzlvLhvi701CIe/fcyQHuLv5xaLLw4QNmrOVb+yQATkBOR98PHOUswMDSF0mkKTqcJeh2sWA4KOlzKzO02uKDkL0/Fn5/MpECFWv/venRnGH1PFkdnoOcamn61/rJgWV2zFFluDXPJ4EEo1YDeKP5gSUvn3YRfsrl/YHk3NGi/iOcjZErw7yYsffO9nXsao6zmVQ6qWK/RdzHQsvsMOLPyrM67w9hL2GaXlLVfYJD+nqSaEb5FXaA2e9k0p2IRM6npBlDurC2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv3/sgFIpLkJFvF9I39vYkQvhh2UyQHO+UI8athqv88=;
 b=ZuwS+t4WfQmeYOehJBNJkZ+VkADtTjhhUkr2dPlFUTJxyNIjAP+urMR+Qakeuo1ndVSl+X68sI/0VHdhYblcWoq+rrpNQifmYDKp6oTVOSdtt9nNQUsfigz1gg2VoBG3kNpEESw3HcIy+qkdx4rcHGhAMe5321MFE+LeBLoZlNo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY8PR21MB4061.namprd21.prod.outlook.com (2603:10b6:930:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Tue, 30 Jan
 2024 20:13:21 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717%4]) with mapi id 15.20.7270.007; Tue, 30 Jan 2024
 20:13:21 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZPmSUZITQDkq6vegFrHdKtbDyrTeg
Date: Tue, 30 Jan 2024 20:13:21 +0000
Message-ID:
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=beac0a21-5dac-4c54-8eec-76ca3372c098;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T18:26:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY8PR21MB4061:EE_
x-ms-office365-filtering-correlation-id: 947d65b7-1a81-41cc-ea7f-08dc21cfe7d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MF1ETwzxTD5oBDh+Gc+Hei0Tus1AiRNKNTpmvsSOYMXv+3mUa0SNksf84yCczuDT1RUWgzvJSkO49f/MpzmEGkPv3KSmeTWIEoFLW8JlsSJliOMxf4e62Rp74sz/HScXmTAg1jAwgaiWPTvHCI6Oo8UwmhkYmI7gyHvsNHi8NtG4LFqgmfidqGiWI9Cd9oUZMfZz9Brh+VOniJyAG+vLKHCS/trKnZJAHlYEB/B0622ESuo3KmEjYDAPLDmrVLJter/bLEjlJKwIjqMT2w91YU+le9u4X2ZjbrcDWEpiZwuPl4eUM/cI61HpIkGfA6mKNL0gGinEkEXOqFP7uB6Z44fi/aSuyy6f++TsyHjORpqDtUxnHRYQE8+olgf9c/jxJj9q0yoL8qg6Lk5ImGXGF+Ys1JBUWWTRxJyUFpkE952SkTzl672ljEQGN9TaVD/mxCeS/9/mxB+7ota/vYK1pp/j08awK8iTUfdaJ/2VGlxGi8aENZ21Tzp1lnroH0uKK9CNfmzNdyAp8Uh4TzyqkCVJBjaimI1BjoU/VLiPmb9j3pegCax7co3oX6PMUrxTBYWcCyFvbu289RZWNcmlPT1y7YBrUygJJubzfo8LIY4DJaXOR3A52nqbpxdyn/XBWKJpOy+XqjR2FHzupEHAdw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(41300700001)(921011)(26005)(38070700009)(7696005)(8990500004)(478600001)(9686003)(10290500003)(6506007)(83380400001)(71200400001)(82950400001)(82960400001)(38100700002)(122000001)(2906002)(86362001)(7416002)(66446008)(5660300002)(64756008)(54906003)(76116006)(66556008)(66946007)(66476007)(316002)(110136005)(8676002)(8936002)(4326008)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ikVS0r+VYoJH8LLcFlr2OxUYCkYXZkSV7MGnUWqBroXUVrAeAckg9d9YXFFa?=
 =?us-ascii?Q?EqDmYUv3YuXXn44AQ+/twyDmB5NpKYHCInilceOPj7STcRG3Wrpp5MTmkjGp?=
 =?us-ascii?Q?QCQLZxpUcfHGal3vkuaIAfWzPaZv05n1D6uR5Kgr1yHvU4BNamFko8SFBlRE?=
 =?us-ascii?Q?ktbZouOWE4NprGjVJfk1nsXxUhvH8oKoC6o809hYRsmohKMwvdlzqI30bZ8p?=
 =?us-ascii?Q?aYRXqf0zQooUiw6WWuE411i0JX2p4F8uQei3XsAHfx0VKzNBO56iHgpdwkjY?=
 =?us-ascii?Q?29ZDtBtrnD25wI0W2ciOS1JXeHn8oMaBZwn19XjrtNy2+zRIWPw3j55eyAcm?=
 =?us-ascii?Q?Phu9EdmU5aUpp8+WonHR6l7Q1ujYd5yhU2acg4rsiBHprupICYC732YSgehA?=
 =?us-ascii?Q?5y+TyBJMUc+yypLe5h2obfJ7pBmz/2q71re0vPPQSGKyT9fgkZPlrHd6GrJG?=
 =?us-ascii?Q?gBtBtIaam0uij3XIgU97xhNqW8/lpis5080GN4M67h/A+69jlHFHHLKAzdnd?=
 =?us-ascii?Q?9o36epFQqpcf4gAwBkIB8tWf9B8vFR43telTC+KVqh4e+4s/t0hdCEC5CDda?=
 =?us-ascii?Q?v4lLOpTEOIUCV4RQ9LLu/irF0eKL9ytCuTFacGBq+T+aTfw9ZDCdCEwVMgQZ?=
 =?us-ascii?Q?JU2Szm7Am/Z8kFqLRCwt0cpS5GMtxry4u31i4h3sV3U66weqahQ4/B5RfV45?=
 =?us-ascii?Q?LBkpFF6RoRmOWJ5sBjWMHUlZTsXf0ouHQjaxgf9QrE9cn3OvW3TmrsN0TeJo?=
 =?us-ascii?Q?lQuOiB2WNRXrf+cFHmj5fPLgCcUgEXf/iMD7he+AP9QPzS+88Ax4DkCWLeTX?=
 =?us-ascii?Q?0HGtYqjsiNGJxRj09BCR+d+suXJWPbOh+ojEZMtLsYRkLiWw5vyBRky7wZ1b?=
 =?us-ascii?Q?l7LCPfG4dP/NWzTgla6oF2VQMBCpj0pIDcPH2k/EAX0rZZcn3hNRHuwQI4M+?=
 =?us-ascii?Q?U85ul2gudo4BoAY6N3GrqXo85jARJQ9FuXjeSZ6T4BKdhlfDXMWzS6quZVp0?=
 =?us-ascii?Q?GHYKdjqki2pl/H/+N1QHawSJ5D/Dz6sfxBVsn8FG+XDz0h5QWyFwK37gICLL?=
 =?us-ascii?Q?jCbZUwMhCjJtW8Bd2nnTkVIyH8qxqPZ1FcYuaA9Cjl8kyJqP3bqpOYmuDOxy?=
 =?us-ascii?Q?AXERm78lxVy1nFHutSBDI/D8FtGaP63LaXqmo8DC5iEATreMJ3Bf8SK9Q1B6?=
 =?us-ascii?Q?BDqUSf+ztloOoSu3VywrWnf9MNlsSA5t6wpytQmKTX07vcPh0TSMZmBqgMrA?=
 =?us-ascii?Q?VLeL1ndocGYTRHiAm0x5DidCH3yNivNYZkODvgIfqdbt0PBXUjuGxogwnFGE?=
 =?us-ascii?Q?Joobdm2C7MFoVhK1ixYjtRLxFHetCd+l1CAYvU74gbGJVfMUTKVgytfIOQsl?=
 =?us-ascii?Q?/W1lszv4HvvAZdoAVunTwU3HkBnkKIzV0WODFQyoEqT2UFUBMP2wXdzF0p08?=
 =?us-ascii?Q?mb2ni3uXzUMXKwvMa71Gfh5dWWe5BsVwgvoxyhwn8vaFd318dwBS93d7OgCZ?=
 =?us-ascii?Q?oaqrhS74pHzB9s3Ug3uf8/GJPFXEz6mjQdrSjg/xb/IOppTqWJUq/3sBuKhq?=
 =?us-ascii?Q?xFqcKc9DBaYruMoVdDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947d65b7-1a81-41cc-ea7f-08dc21cfe7d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 20:13:21.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqBS1aXbPAH4RuvUP27nZW8lA4qAjwlE4MsrEBnBo/us7aJ5ZoH5r2seQjqHqRhe974PujXhZbtejmsPM81tiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB4061

> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Monday, January 29, 2024 11:19 PM
>  [...]
> If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER

s/removed/unloaded/
unloaded looks more accurate to me :-)

> [...]
> Tested-on: Ubuntu22
> Testcases: LISA testsuites
> 	   verify_reload_hyperv_modules, perf_tcp_ntttcp_sriov
IMO the 3 lines can be removed: this bug is not specific to Ubuntu, and the
test case names don't provide extra value to help understand the issue
here and they might cause more questions unnecessarily, e.g. what's LISA,
what exactly do the test cases do.

> +/* Macros to define the context of vf registration */
> +#define VF_REG_IN_PROBE		1
> +#define VF_REG_IN_RECV_CBACK	2

I think VF_REG_IN_NOTIFIER is a better name?
RECV_CBALL looks inaccurate to me.

> @@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device
> *vf_netdev,
>  			   ndev->name, ret);
>  		goto upper_link_failed;
>  	}
> -
> -	schedule_delayed_work(&ndev_ctx->vf_takeover,
> VF_TAKEOVER_INT);
> +	/* If this registration is called from probe context vf_takeover
> +	 * is taken care of later in probe itself.
I suspect "later in probe itself" is not accurate.
If 'context' is VF_REG_IN_PROBE, I suppose what happens here is:
after netvsc_probe() finishes, the netvsc interface becomes available,
so the user space will ifup it, and netvsc_open() will UP the VF interface,
and netvsc_netdev_event() is called for the VF with event =3D=3D
NETDEV_POST_INIT (?) and NETDEV_CHANGE, and the data path is
switched to the VF.

If my understanding is correct, I think in the case of 'context' =3D=3D
VF_REG_IN_PROBE, I suspect the "Align MTU of VF with master"
and the "sync address list from ndev to VF" in __netvsc_vf_setup() are
omitted? If so, should this be fixed? e.g. Not sure if the below is an issu=
e or not:
1) a VF is bound to a NetVSC interface, and a user sets the MTUs to 1024.
2) rmmod hv_netvsc
3) modprobe hv_netvsc
4) the netvsc interface uses MTU=3D1500 (the default), and the VF still use=
s 1024.

> @@ -2597,6 +2604,34 @@ static int netvsc_probe(struct hv_device *dev,
>  	}
>=20
>  	list_add(&net_device_ctx->list, &netvsc_dev_list);
> +
> +	/* When the hv_netvsc driver is removed and readded, the

s/removed and readded/unloaded and reloaded/

> +	 * NET_DEVICE_REGISTER for the vf device is replayed before
> probe
> +	 * is complete. This is because register_netdevice_notifier() gets
> +	 * registered before vmbus_driver_register() so that callback func
> +	 * is set before probe and we don't miss events like
> NETDEV_POST_INIT
> +	 * So, in this section we try to register each matching

Looks like there are spaces at the end of the line. We can move up a few wo=
rds
from the next line :-)

s/each matching/the matching/
A NetVSC interface has only 1 matching VF device.

> +	 * vf device that is present as a netdevice, knowing that it's register

s/it's/its/

> +	 * call is not processed in the netvsc_netdev_notifier(as probing is
> +	 * progress and get_netvsc_byslot fails).
> +	 */
> +	for_each_netdev(dev_net(net), vf_netdev) {
> +		if (vf_netdev->netdev_ops =3D=3D &device_ops)
> +			continue;
> +
> +		if (vf_netdev->type !=3D ARPHRD_ETHER)
> +			continue;
> +
> +		if (is_vlan_dev(vf_netdev))
> +			continue;
> +
> +		if (netif_is_bond_master(vf_netdev))
> +			continue;

The code above is duplicated from netvsc_netdev_event().
Can we add a new helper function is_matching_vf() to avoid the duplication?

> +		netvsc_prepare_bonding(vf_netdev);
> +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> +		__netvsc_vf_setup(net, vf_netdev);

add a "break;' ?

> +	}
>  	rtnl_unlock();



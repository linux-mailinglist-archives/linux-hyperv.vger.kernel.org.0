Return-Path: <linux-hyperv+bounces-1479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB1842625
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A994EB2B1ED
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1C6D1BA;
	Tue, 30 Jan 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X4/L9mn0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F86D1BC;
	Tue, 30 Jan 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620773; cv=fail; b=kxGQJ5OUmFSaIJla6cUXq/iHMaHYng9aBT2NhXFGFmzaUEjj9LM0t1s5YqSnR/RYnJ5L/Rm4axn3JUeVlLrETJ9nTLz8xZX/bsC5vXeUUTcFDTG5UEcRBR7INNWkQ3acgm1JPLEejTV90f+yA3YkSWumd9ipTdNE/Eh1bSQbgRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620773; c=relaxed/simple;
	bh=6of0/oJtt4gnVGq9xjpTc1nvsP/B2vxN4zLfSZE5NmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRcBGXSzPjiA0nmKoWyee5xWb+gwpFNkkJMYfMnByjtQxy9F0hkp5arUKuJimfyg31WbAd8lwDBMaizc7UAOH8sGwbAm9LMXoPdHvlPJ4ICbX6FIn0PUYjAtVCcGK487ggUIEcyf4XCOKSQnnpQeE1DLNkJb8KOoacw/8QRz19k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=X4/L9mn0; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIoS1Cr9bzYSHz2KgImEkFer3+z5bP3AaZkVK+KJ6U2idLVWL5A87n1UADa2kk+vu6dQkB5LPN7kl4dV6F1Ido+DdpCfcCejuX8zJd+JuDy7jUBXTVMZqt/FvlwD1vgRH+WhQiF4Wx8GXBAUlDXg84WlCK4ggXVHJBwI9cY1bK5aSFMy+O1u1m0ZuWjpn40E6jECvwkbnQepuhfKn4m4YOWG+IKqQRSUtZo/JerjoUHdQxF1719EB0lnHeC0xS+lK+C3UKzQT2ijirirWlZmnt888p9rdDAXcfy6+ahhp/uez18MJMG/WkjTABVeJ3s8/LQd5RLQCvRxVNmH34sZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uelUaQzzpbMYNuiLW6pupqr/SqZmFbGR7gX8aDWvTA=;
 b=UpkH8P/wX+yzt4PkOMamgZWCeMGNN7/gczF6yZG2Nt0CrpPxrCSxiF2PWk8ZMT86vBMumESLK9hiX6DPMkx9H2IcbdG48ylUDdvluRPwWm9b6bQtiTNhOFl7gQ7eN53LpKkZ3YFUGLZwfp+spXg1Sj0atEuGab31opgw+8LqEecj+z/caXsaRquHpwmoa2q7vrb594uSHx0N7Co3gyzriBJYb8GEmHN6mXLyt5p12lazFSCDKD0fLQqAmAAF6z+anbqY/Nw4jp3SnrYpP0jZdiEDsJ6M0hPhPSNDXuY74VtR2A3XTJ5SHvsBIvboSeXtTFVUR798ysXqKKaUCCy8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uelUaQzzpbMYNuiLW6pupqr/SqZmFbGR7gX8aDWvTA=;
 b=X4/L9mn023l+SS1Yu1eNAJ3UoUM61wb6nmQpEGkW9LatrmZHODeadO5KLURUvWIad1DUFi+O/VxCJNzh63toXJOyQdUXgHec/H+uzz8nGRjznklXRcNtKsX8qo0SVRJNbmWWlRGwvHCIpAVBRwsp8f56iSveeQfM3sFACfdxJRM=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by DM4PR21MB3611.namprd21.prod.outlook.com
 (2603:10b6:8:a1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.6; Tue, 30 Jan
 2024 13:19:28 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Tue, 30 Jan 2024
 13:19:28 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe
 and netvsc_remove
Thread-Topic: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe
 and netvsc_remove
Thread-Index: AQHaU2VfqcUSLtQeAUKy9jGiH9r5srDyVg2w
Date: Tue, 30 Jan 2024 13:19:27 +0000
Message-ID:
 <DS1PEPF00012A5FFC608BF1BCC9F36841F3CA7D2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706609772-5783-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1706609772-5783-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=506c9f8b-873e-44f1-b711-91f5bb222c35;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T13:15:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|DM4PR21MB3611:EE_
x-ms-office365-filtering-correlation-id: f6f2a8ab-5c0a-4d89-b6a5-08dc2196162c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fU+A+qs3tNGW/1kzLV4XgHoZASszF/VI/ioRDVHQiyYLyV+fJZT9VbwIaG4kciFxKamGPTLAP/G/tINa8s6g0u983t2r7AFf/g+3p7ksC0UQJjNbn1nkO5P/6ka+s+G86x/vzBYGORgRSNW4HDPVFblwUsHfGHaZtx/mJzzYCVkD9wjyK64r9efjRKqHMV4/zjD//YhURYDnM+UfjlCs02T5ZN2spE/36bSgbWzHT3oSvsiaQwrSpq2YIb5TO2P2UPM8tnPBwP7lbROymVZGF948eb2G2R+Za8io59OJwM4wc7fQTuWNUswMl49UXFmNnbD4dzdFs+oOXD899UzEo7h0DmWjCXNrGze43SWnUQir9KWsodqvq96qbepJRuLMIYfpND8ChjAdXK1TcS63bX+ZsNqgUIWlI7vWxBULOBqGVnKSypunj0Rd3twVPNIc01uhK4esojYjYjhvV1lBq6TlApttiBksKtFYi7Pjs9XZ91utSpIxVpd6s80nJU+afcnQk8C74S1VvqC/+SjWl9Rm9JsKQz4PNHKHSM/1LBZH/GqlYqcySibyFwiMuA4CZcXztmVNR+GYSXk7nwBW7+7JF7Scwc6cDOmiZ6j8Jmg6Y5rljYEgy+Yp3DX+oAYwKWG9yDlcPJQ9tfKfTUWgyQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(4326008)(8936002)(122000001)(52536014)(5660300002)(55016003)(76116006)(66946007)(86362001)(82960400001)(38070700009)(8990500004)(110136005)(38100700002)(82950400001)(41300700001)(66556008)(921011)(33656002)(7416002)(316002)(2906002)(64756008)(66476007)(66446008)(83380400001)(478600001)(26005)(10290500003)(107886003)(71200400001)(9686003)(6506007)(53546011)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PA9FAfaxU4W8afGxWN8E7Z51pxvTCa4b9OdU8DjSLmTICR/gEOYHR6GFtg17?=
 =?us-ascii?Q?ZGlxklmKn4hXSgJ3IwDpBFOS3bssW7gbvgxqtFnaBRt5Pldv6aqYnKiCM2Za?=
 =?us-ascii?Q?R026d8KUrBCJEhb+3OP8LPTtvZVpUu55ptykyaMX6sMDEN+bv9YiKLJAgA5l?=
 =?us-ascii?Q?DrLb6kXhK1obLKa5FtZLLNNvhyHy9Iy/RgelSbgNrnTBTbkcLq/3RSVmk5Go?=
 =?us-ascii?Q?N++6sdMTm2dn3G0/mbQ/ioo/hyYiHw5Q7VQy/UzqyUbIXoUId4DgzB9bfoW8?=
 =?us-ascii?Q?mzaqcReq8vX+/xBy4aTELbQ3rZcOjVBOCcWjBNHzmlmxjngWDxJ8f28v1/Aq?=
 =?us-ascii?Q?nOghlZ6G7JbhJJX+1O7FUSYRJ7v+yRvfEsvPWbzE88bw6whekgoojlnY9VH0?=
 =?us-ascii?Q?AVDGtuLiDxVZF0eA8dSXytBRoBRyfGZ/wmE/8w+LrbQGWBfAkUJ19A6m30Ql?=
 =?us-ascii?Q?80Qb9W6jsndzVyD//mU/LY6N3N9exdZhau8kM5VqJZSPpCvHTuyIR5ijIkdn?=
 =?us-ascii?Q?5QqUvZ6nYGr8uB42BtmCb81D0u7YHR9aJyAoB2ROttj/AJBlEMPJD8aCadHP?=
 =?us-ascii?Q?6t9TVsOAxRPdfwBzysPkq7vFLxYa/BO7Hl/o2amwcTmEe1zSzZzRlcuqEJzk?=
 =?us-ascii?Q?QHr83risYs53kVrRvayBACpY8LHC0flMkabnIeLm4O/k2lKcJMjQeaW0ELRo?=
 =?us-ascii?Q?/YbewIm1LszSsEIzM+9OigvCJlSmNOsUwKMv9YVnGtZY43klXD6mvddu1xGa?=
 =?us-ascii?Q?2HBUtpN1JWdhlz/s41epkM0Igsdyhcl6RjsWkn0+BY/JjriP+m3eatV19DHu?=
 =?us-ascii?Q?HDrqY1VjLxFQgCdouUP7MHIzYItDCWBxExZn0RC0EzGDZ/Ab3e7JkOc8RTk+?=
 =?us-ascii?Q?1vW/sbF1Xw/tt07R/hBgHt8dNr3rE7Y2UdCA7WNDwxBg8hvjfWl7PBDmv2qG?=
 =?us-ascii?Q?xGFUb28YYGrFbUp3uj9rV41N2T2TMG4Tgqa+GBwyQwR+LCoji0VnjZPFGs8Y?=
 =?us-ascii?Q?WUWcR+YXc5zMRX9UIb7mvaCS5MBGO/7txLN+OezxEL6Bq4zOYb+5yo65NnMK?=
 =?us-ascii?Q?9CnvqKfYi2oR9ARLTEZUQYwporpa3fbODWNmeju33jWvhfvdjUFiIlAN8c2A?=
 =?us-ascii?Q?Ek/0jWk+BBVpQmYk+IF+SkwRY4cVIhcUB/ERLFftxFX52dOCDZekEVarX+F7?=
 =?us-ascii?Q?wyXoA64PoqryfJ2spvE078Ah3/0RXdKApt+VKKF/bDwRtrBlweQjOk4Q5yLF?=
 =?us-ascii?Q?NpBMfvP3PxfmxJuC9mV1Y+m/NMm2iU6MFRQZpZ5RVFpRQA4NBMyzOMcHxz93?=
 =?us-ascii?Q?JZwFMxjy4V01iqwcn49/VlKU6K+9lndVQj5I/2RhyKDL62ggYgFhmgJG1uJi?=
 =?us-ascii?Q?AEGkdzbzvPsxAdPT3WRE0DMm9oXa1dflHs/atbm9/c7EiXKiK62cKcItJUBo?=
 =?us-ascii?Q?Vw/BtB8MZsm71MYhOJRUXcZucFsiY2PaOhT4FFYoJR11ml5LSCWEve0CYtbZ?=
 =?us-ascii?Q?BXugCJvQPZGvD5YcQXF0eN1xccWF5jr+rOIrvPQ9jQzUYvyryZ0r7qDmGq21?=
 =?us-ascii?Q?XqtZ0Bewu1c0mqn8HAdzVEQQtKNe5Jl6Mpj7fi7t?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f2a8ab-5c0a-4d89-b6a5-08dc2196162c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 13:19:28.0189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edCEIwzWMNAVJTcE+zQ1xFablhGDXYQqeWYu3FyKL1Lzf7AZq8/P9HnKZ6BHtvL/bfZo8SgPk/q3db0nHLu/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3611



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Tuesday, January 30, 2024 5:16 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> yury.norov@gmail.com; leon@kernel.org; cai.huoqing@linux.dev;
> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Souradeep
> Chakrabarti <schakrabarti@linux.microsoft.com>
> Subject: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe
> and netvsc_remove
>=20
> In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
> VMBus channel"), napi_disable was getting called for all channels,
> including all subchannels without confirming if they are enabled or not.
>=20
> Which caused hv_netvsc getting hung at napi_disable, when netvsc_probe()
> and netvsc_remove() are happening simultaneously and netvsc_remove()
> calls cancel_work_sync(&nvdev->subchan_work) before netvsc_sc_open()
> calls napi_enable for the sub channels. Which causes NAPIF_STATE_SCHED
> bit not getting cleared for the subchannels.
>=20
> Now during netvsc_device_remove(), when napi_disable is called for those
> subchannels, napi_disable gets stuck on infinite msleep.
>=20
> Call trace:
> [  654.559417] task:modprobe        state:D stack:    0 pid: 2321 ppid:
> 1091 flags:0x00004002
> [  654.568030] Call Trace:
> [  654.571221]  <TASK>
> [  654.573790]  __schedule+0x2d6/0x960
> [  654.577733]  schedule+0x69/0xf0
> [  654.581214]  schedule_timeout+0x87/0x140
> [  654.585463]  ? __bpf_trace_tick_stop+0x20/0x20
> [  654.590291]  msleep+0x2d/0x40
> [  654.593625]  napi_disable+0x2b/0x80
> [  654.597437]  netvsc_device_remove+0x8a/0x1f0 [hv_netvsc]
> [  654.603935]  rndis_filter_device_remove+0x194/0x1c0 [hv_netvsc]
> [  654.611101]  ? do_wait_intr+0xb0/0xb0
> [  654.615753]  netvsc_remove+0x7c/0x120 [hv_netvsc]
> [  654.621675]  vmbus_remove+0x27/0x40 [hv_vmbus]
>=20
> Fixes: ac5047671758 ("hv_netvsc: Disable NAPI before closing the VMBus
> channel")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Please add:
Cc: stable@vger.kernel.org

Otherwise, all look good!

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

> ---
>  drivers/net/hyperv/netvsc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 1dafa44155d0..a6fcbda64ecc 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -708,7 +708,10 @@ void netvsc_device_remove(struct hv_device *device)
>  	/* Disable NAPI and disassociate its context from the device. */
>  	for (i =3D 0; i < net_device->num_chn; i++) {
>  		/* See also vmbus_reset_channel_cb(). */
> -		napi_disable(&net_device->chan_table[i].napi);
> +		/* only disable enabled NAPI channel */
> +		if (i < ndev->real_num_rx_queues)
> +			napi_disable(&net_device->chan_table[i].napi);
> +
>  		netif_napi_del(&net_device->chan_table[i].napi);
>  	}
>=20
> --
> 2.34.1



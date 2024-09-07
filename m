Return-Path: <linux-hyperv+bounces-2984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4496FEBC
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 02:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5ADFB21B47
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 00:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BF34C66;
	Sat,  7 Sep 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Co7Vhxfw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022085.outbound.protection.outlook.com [40.93.195.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB34256D;
	Sat,  7 Sep 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670205; cv=fail; b=S+x9DXf75PbRIE+Rh22d10TxUZpE7EKP2Eq8yMaUfTkelNDa/gv80DyRdivanOaOJMIOVMANhWd9bJ1wKnVSGSjIHkHQdcLran8djeTtPf/0vAtpAilCi0apuHWJgD2dw1fYUNNL99SNNUx4fKHkOcCCAnViIDfMsi+TOx2rAIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670205; c=relaxed/simple;
	bh=wqUejg2RDa5OT+VliVRzACgXcMIjF3f97sViaU4j0HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kXng01RC2+MTceBCVv1gIBrbXtASuT1ONK3zIKNjFZM4UyRDguJy9mfJZTTldrbTMpDUEsYnVnFoAJlCtG1q5BOvWaXE/cHT4woj6AtcR6mQEF2UGKBPOtdBsuCv869Htl4xQmpLqP/NcNAFnazPazU27elUuTX9IxitDt/ch3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Co7Vhxfw; arc=fail smtp.client-ip=40.93.195.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZTzu4cRjXWqMNAQLQ2i+kfPwXdqtPaH2ibzI7f0vEd9JSZJu6vHX64UcJG4ErD1CeGVuqe0W13bnTY3o+84oz8DOVa/wC2ue1tlLYZsn9RKKMsZouoRCzn2YMG8ixtVoNMxgqIEtoVtPZ0KTdd6w4k6v+4GPn/T1nomdh2mECbWqKD16eHvmqYHs27A4ocsQyzdtTVzn0P2nrLXYICntMKANidSClyA5mwqwieiP1pg7IHfhdq/g9iVxZRAhwGXT9hmkW29hNkhhXx1NUBCqivicPLO8DLs0HAI/tI677kywoAcLF3zQ5ADENlQS+MjUV6slN9Bapb2NvDzDkVAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S+F4zZG3mrppOz9z5qsi8kquGRkks215Qom8d6CRl0=;
 b=Nv/4Fw/VCXT13jQI+3C1cRRL2btrpIPflWx+fo6MkYLl3J4A1jC45x4w1ZCQPFjG76UUXTDcpjLnYgYIL0aDMahT7bO/4c+reHqYG6JZ3e1BBfKZCWPfuDFyOc8dujmbW7aY2gA0Yp/4wm4eI1IwoN2eYHuoVie9JgA5pbe5Q7hHFpvRN+qD9KLBwgsreneSaI1bYpOF2a0p4YHwXg5gFi628z0ON1ryMDFJyZfRg9/ytiejBDtcnF3RMAJydDPxdGuBUkbHWvOQZJkl14jKJO9na9wn1FRJdsOY+ULAhPjDkcmLOanzfW7MWZhTiVJooVsIQPK/E74xXT/E0UTkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S+F4zZG3mrppOz9z5qsi8kquGRkks215Qom8d6CRl0=;
 b=Co7Vhxfwch8E3uttja40wQqGTT/CD/AG5cnIRuSLiGGsnBWRS20Fz4TK9MM8pMpjuOI55N1zM3bfLm+vnvGO0TaRKPI9nJNxtOeqKv6oxHIFU7jJfLHgqRNqyFgzJLZzQb84kyMK4K1pEQst8IlHHuTSGp4FrK7z5r/TxpLQxb4=
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com (2603:10b6:a03:3f0::13)
 by BL1PR21MB3043.namprd21.prod.outlook.com (2603:10b6:208:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.4; Sat, 7 Sep
 2024 00:50:00 +0000
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::4e67:9db5:14b6:2606]) by SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::4e67:9db5:14b6:2606%7]) with mapi id 15.20.7962.002; Sat, 7 Sep 2024
 00:50:00 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Zhu Jun <zhujun2@cmss.chinamobile.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Topic: [PATCH v2] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Index: AQHa+b1vG8hrFEeCykO1A3EareCyOLJAhOwwgAguQoCAAtWVwA==
Date: Sat, 7 Sep 2024 00:49:59 +0000
Message-ID:
 <SJ0PR21MB13245A34AC4AC3638F2108DCBF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
References: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
 <SA1PR21MB13179B929747B9B88948DCA5BF902@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240905052033.GA378@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240905052033.GA378@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4dbeadfb-f160-4131-93f5-c1bb6c81d949;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-07T00:37:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR21MB1324:EE_|BL1PR21MB3043:EE_
x-ms-office365-filtering-correlation-id: 0aea7a1e-6406-49dc-3c48-08dcced7006b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uAfQC4kaOIpZ2mBBKhVIIa7H8JZ/h4awm8/SEqxOvpGWOR7Y3ZhcOKvKDRRv?=
 =?us-ascii?Q?fC2K6PyW3RtHCmLGOJLWZYn3Oa5KhGVJGYIVc0fZ35WYXruLR7XUQT9Hfae9?=
 =?us-ascii?Q?pcAK/cYkblU1KgXpKPTOlOFiajylj90hjvTZ1w7XEhAScOIMxy2Nv/ABh/cx?=
 =?us-ascii?Q?M6pJkki5lYKGkDMisOx1K1j6MHTFSjmBLvB3gj/kkdLSmMy8ovrvGIjnopod?=
 =?us-ascii?Q?ZRwzSxyu2VvqlA4Ue3uA1tu58tyt6K98tfeR9BNmjwwhe1S0oJk1JXraJ0FP?=
 =?us-ascii?Q?oAK5hUjVE/7L84+8DuIJZ0o/uUDtp7kvsQt1z7X+dy+bJ1UbNnTWb79PlLOe?=
 =?us-ascii?Q?2EkaYnGRubn4w+CJQkiBf8BLTKWNHMB2hohBV4l0HQXTyVSDqI7PNHxVsdXY?=
 =?us-ascii?Q?Q7Pa9NQXq+j5agQHS1pRTruOCdQsR/yjjXoycSL/tLD8a7i9KUxxxxV7dmEx?=
 =?us-ascii?Q?cDIbhMqMWow+CuqMTtvwZrhRb66sqf6M6Ck+oZkix9G6qyzCQ3u6uvpi4p4x?=
 =?us-ascii?Q?Nnqc3WJjbrWpGxvO0yO7ZKVQPTiLNulCPaQHiBTO21HJfKtRPk3k2n5EKHGJ?=
 =?us-ascii?Q?nngPLlXpYOL3X46+gGseN3Cth8zaB6Mtjg2vf9X0eztNV3dWDKhEHqtLIDo4?=
 =?us-ascii?Q?GXepMRiogA2GOZct84195c89ZndyeXtb7/61rq8/BOCwtzwUWSIkMHZVpWRD?=
 =?us-ascii?Q?bV8vNn/c19h5kuj7n9i0OwejCqzebEUfvqLKgcX9yCIr+tcG/d6us/PEqXVd?=
 =?us-ascii?Q?amXwSHi/yxuDjMZ5LvxtZ5uZnx7qJwdwqT9EOXKBfIbtmDShbrJ4FQRcIN3G?=
 =?us-ascii?Q?mRgwiA3Strb2Vz35iQgEX0ymN3s+Ng6bwRSwNKcn/K3I4wDxZXUd+WyuDxey?=
 =?us-ascii?Q?P8XQJpxA6NHNuCXT6RLoOHwoK5XP4QOREVr6p+um9kIX7xFktM5OWS2U/Dic?=
 =?us-ascii?Q?ImN24udgv/k+YmsPmEAaN68Lh2KowuQ6ynfFEBGhlUQoz4kgEGOsRnoFCPwl?=
 =?us-ascii?Q?fQdSsCdZw3QZ85EpUr3sRGqes1GuYq1f2ke48ww80yjrQ2qhpg70XYwOlspR?=
 =?us-ascii?Q?9YKNvkGRQooCQ460sh3ATmBoyOMPbztxbrsf9+IXE0NC/4ksavBkuAc8wdgB?=
 =?us-ascii?Q?yFY5DeYFA9ToZ9Nxjf9GzOBqhYM2PLy3wlJKKOWj0k5KYxGCDuBusczq51yx?=
 =?us-ascii?Q?5cuchzWSXE498PJ/1fge7jABTdxqptWqLAQBg+AFm5hMzsUPfLbT7jiVc2lw?=
 =?us-ascii?Q?MydC/m/LHCwa0WER8E+VW49scH7HpzQlOaSDuIAd0umpqvMJ1+zW3YX/6Mtm?=
 =?us-ascii?Q?r7Zu6YJ8rtefglIZ84DpY4LDB6kd/eGAo4nUhJLL7+PDSm0ZGWWZR/+Ai42H?=
 =?us-ascii?Q?+lnhbPDiE2DfdQeg0xKPsPt9rDbOW4Wf9nfWhRIRStLFnWda1w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1324.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BVtiggi/jn/JJnHkPGU6gCo4HaR7cCVJAtWG3fcVuviYclpvqGNjUkAhBybs?=
 =?us-ascii?Q?Cku9TiNOtwchURnIF/nkW7ziwnCHfRZOVojz9PzYbFqHA+frUM04YwgVohT7?=
 =?us-ascii?Q?xWX7TrXsHy6zI/xRlAISz9t24cByVc1Xh2EZdDFQizFB1b3zR+Qq0N21H7zL?=
 =?us-ascii?Q?dQe73S3dOXzNSWhLlR6BUz6SxYv+rGZjj18Xj4uTF4jeEt8WWtzJl1WH5WYv?=
 =?us-ascii?Q?z39OFzPw2v+V8OZp7pQTA3+bdkAMqWDmx/aDHNx+/MMUNQ7hwxl6mpO0t5dE?=
 =?us-ascii?Q?2/eR1y5OkP//ZbtkzZ3AxMD3S3AudexnGLTuiAg/wH9NHGb0eeeY1XrcB1gB?=
 =?us-ascii?Q?TwelsgDreeUQ8WWkcoU0QOgXWHXVAj9KDWbCNwMYD3tEscWZE4ge99EDjwPt?=
 =?us-ascii?Q?Gv/2AAhTnSGh+PwhEoxlAlRodqigUZuPnxUKAOQdG1WStqQnOgty+ACFSAym?=
 =?us-ascii?Q?7kNsX2RKwEV+MIXm9U9EXjNtT2J/KBc99r0YPtD1dkH1tvoqzNwqQQt1K2zr?=
 =?us-ascii?Q?0axPRun+cOhSp/0Ni/Po0XKbxT5cpbqmKhPyZid/ohJ/wWlHEbL/hhlEFBu2?=
 =?us-ascii?Q?VOfZF6N0viTe1WeRB3bA5IYii5d7fTTjZ+nLn1zrzzQ1esCvOpUuGMHOF3Hq?=
 =?us-ascii?Q?yyAIcu8kMJ54Ic/1KzNvXJSnTmvp94XemvU+woaTiF1H5uNSjgkpB3OQgJGf?=
 =?us-ascii?Q?ZJMgnU5e7z33uwpHG4cf2K4hH8S3dbDTeq6BBPr3JVploT9jje3lF8N9qZXL?=
 =?us-ascii?Q?4/R38j1KOg362d6/ZiCnXdU4MvnJbubKDFreaDRDeYY6DhdC9i5SdDiOgfjL?=
 =?us-ascii?Q?p90CrzvhrA3lbrkVTxF76iazmcZVpz/V32ff2Ep63sI4fGhrddpWm58G4f1M?=
 =?us-ascii?Q?MJtXqQnhKPCmqEqoOfEBVyLrlQqW7EXYVaPMlrMTvMMDoiNmDtZg5d3hnKyn?=
 =?us-ascii?Q?mrg3PP8aT22KVXjmc6R+0hKz/eNg0ugfIoDgM5NNaMas6EpwLu/h93l0CHOR?=
 =?us-ascii?Q?Atul8UE+Awspkz88tAETwPIsSouXk9Y56Fg/xftW84CPqEeTWohvUkcjPBOm?=
 =?us-ascii?Q?ljQ2F2lwlAFgEoJ5s0dj90p1BXLjMUd5nIcdg0aOadyCjxyNYwJr9ptetyOI?=
 =?us-ascii?Q?jmTT4YAjXZLArnwXBTycCncgPzJ2SDqquv7BaSEwVzY6dzaGh9gPnww7aHoG?=
 =?us-ascii?Q?D6BWmb/LTqKM5xKQX2Bd7NoDh2S0dVtwvJMqrQyB1qUyr98oxZSt6LSX0ixN?=
 =?us-ascii?Q?DIFuZc/1bxSRwNGapRgFxHRh0v9yUAjwvQESNoTaHQLGvfcnPBiryrz/hvdg?=
 =?us-ascii?Q?nvphDb304pZy9ok41H0QvBDqtO17gjOKnNzWjUto2qG9qy/B5fw2LHpjor5z?=
 =?us-ascii?Q?m5aPQ/lsVwVLl/nCxNgGHaoAQBgkTnkDWTMUPLf5uE968TtkjqECvtbWEyZb?=
 =?us-ascii?Q?aRPw/aUxYpyCc1GWMUItfO1P6DhA+IFiXnHQRKjZGplDO1c84khadLVwXS1k?=
 =?us-ascii?Q?LvbhTdU7POKLVGkk54FFzImsREuKhSC7KBlXmGIezKQ0q/td80NxR3RArJt+?=
 =?us-ascii?Q?+sobYKkUQBQ0X5CA6+gPpohIxzeM2DURx3O5yDAtDnEm+wWgO41QukEIoWgJ?=
 =?us-ascii?Q?zCKprneQ9o5L1LVHqyBuSLeSULeIRJ1zFjOGyUrmvCWo?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1324.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aea7a1e-6406-49dc-3c48-08dcced7006b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 00:49:59.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEnAHa48xTzV5wuU/7kiXPevcSNg7GBN8nP3d66pckKsiUfV6MV7ANIlhUrHxRYvH5f3kEmw6gM+LRqIWJzbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3043

> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Wednesday, September 4, 2024 10:21 PM
>  [...]
> hv_fcopy_send_data is the parent function which calls hv_fcopy_start.
> Possibly a good solution is to check the return value from
> hv_fcopy_send_data

The return value of hv_fcopy_send_data() is saved into icmsghdr->status, wh=
ich
is sent to the host, so the PowerShell command on the host will report an e=
rror
immediately.

> in fcopy_pkt_process function. Otherwise I prefer exit over returning err=
or.
>=20
> And as you rightly pointed out if we use exit, there is no sense of using=
 free.
>=20
> - Saurabh

exit() here is not ideal in that the host doesn't know what's going on insi=
de
the VM, and I guess the host PowerShell command will time out after quite
a while. Without exit(), the daemon can continue to run to accept the next
requests from the host; with exit(), we rely on systemd's Restart=3Don-fail=
ure.
I prefer not to call exit() here.

Thanks,
Dexuan



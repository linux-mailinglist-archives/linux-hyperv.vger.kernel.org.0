Return-Path: <linux-hyperv+bounces-2626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A993FEF9
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0911F223C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5201741D9;
	Mon, 29 Jul 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YUS7dxHC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020078.outbound.protection.outlook.com [52.101.193.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6C37708;
	Mon, 29 Jul 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284245; cv=fail; b=kPDD1Vbs7S2WMwywGjYer2vpS8jxHrwMEsO+7q8dGKX1SyR1iO3r4KMZW0sKbVsBSEy9UWpGr5loLv9lVUoo1B3R/FTEqtNNmC2Y5CVzadQVw2l/p+wLH9rp57TeAW+il9cjR5PUEcQKL5z4Bi3s44E0/7XtZngDyunYdxe2Sck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284245; c=relaxed/simple;
	bh=90mCfNCZBbGmFXClQDvFE7z2O9SdUd27IJpDJjMooPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgVaTRGKXj+G31Nl+oR0IgNwXqWQczJXF7zcFMm8ALw4ZTXumH1My0/4eRZ/Iug91+19gT8MA9mdjhAwGaNhCDV2cCi7VxJht+JqVLWlCbBuG57p3oSwBZW+/zYTbfXoDsIc7LXEMm/8haWhbxDzCHhU1WAWDVcdVlhG8sFQ84g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YUS7dxHC; arc=fail smtp.client-ip=52.101.193.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYlVr9+y5KhDZSn5R6PmKPRE8/AEkheLAFPJV8o1/22pc+yXSIFkul+wmR70Ro2MyHWZFz/iTN2S8X8xDbMCbnToahDzwUvJKnUteCN4wUxtwKUhSu0K/zas64kB1Lbp5H2NMxylosqeUeCPNZH5cGk7SHSU6wUq65lXlEiHXI8Wrr0vK2GyIQk3GBiD/ZxsCLWOU+RNEx9LaBKAYG2TRfma8bG5xBOMbpW/L5CFCZI1WzPNtkqJxF5GJ0h+XNT8sV5QYFcjcr+5yg7alskUYtuyHxIggNpbSujvf9kzB5cD6J0FwS1JTqad5QsfAOIiZG+H8WTaU7Q8KtYelCXDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEb+WuPIuExYVLYhrvBMYNwh2T73vUcQUhGHvgobT1c=;
 b=haRtZeLkTuTh9I58gBrMUSThPNH9Y1xUZGoUMANulTFFLarU2zcDfOIfpGW+Q0hmynB/Y+18EH7WvSPBqKncg5+G05fNFbfM/9aIu5KscwPVSsu1DXrMYT+elituJcjA68OlQa2mLJPXtaM5CPT1nMu5wGkRWzlRB5AOPWFCBqMIFWNmai6iDLLgQ5B1ElCrz8fxJeEvH0qX8WbwbVv1Sp5S4BNVIiuZuZ6NP1jUj4tYWPPYL6bh63lbnrGsAUF1eZhleF7xbEV52CCrtSJHp+cl6SCFBS0nxKlGp5sHPPIIZRuRzTLawVUBkIMrH5cF5Ie5+JAeYAf2JITBRxCWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEb+WuPIuExYVLYhrvBMYNwh2T73vUcQUhGHvgobT1c=;
 b=YUS7dxHCv16dvHCB1HOG/D8trwB4ztOD118zg/GBd1uSBX9J2AcBS9SNkmsj8rK+UhbBUspy8/scRwH2grPwtC1llW90AjYb2/BclbB85I8y6qXPRClAGCZGjkmf9udsFtFJiNKdfRyBmuPmfqfxewsFE27DjRnpH9F3TKCJl28=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by DM6PR21MB1498.namprd21.prod.outlook.com (2603:10b6:5:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.3; Mon, 29 Jul
 2024 20:17:21 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%7]) with mapi id 15.20.7849.002; Mon, 29 Jul 2024
 20:17:21 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Optimize boot time by concurrent
 execution of hv_synic_init()
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Optimize boot time by concurrent
 execution of hv_synic_init()
Thread-Index: AQHa4Yz1qgB4iDDyG0q2bjprWsok8LIOJAyw
Date: Mon, 29 Jul 2024 20:17:21 +0000
Message-ID:
 <SA1PR21MB1317E317DE46E7F5DB8364BFBFB72@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <1722239838-10957-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1722239838-10957-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb7992d0-b14b-46ba-985e-e59cdf6940de;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-29T20:12:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|DM6PR21MB1498:EE_
x-ms-office365-filtering-correlation-id: 57a6ce59-85f1-4db9-2094-08dcb00b73d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KMmArnmY4Qf2VRnSUkQlHoszktm6vJGHzsNlm9p9WDgIqcegoAT2+ctIOtVx?=
 =?us-ascii?Q?DyIIQLa/cr4eeAJoZggQao4qpLcgLu2YfiANojJJ8j/wjimWLh7CTveEyaVz?=
 =?us-ascii?Q?FbOVM480wtFUjng41Tlh7CavuUgPcunSGztP2zs0D2PBzJvRw5yol5ZYeZB4?=
 =?us-ascii?Q?4SE4fwrC9tdeZyfmTjVTNZnZ9mq9XHX3GEWMlvYL/jzpdkQ4xWgETnTP/cPg?=
 =?us-ascii?Q?x4TZP5qHzAYhDELnrm5Z/NxfYRCTUHpNBJ8SfVx9N61mpE7x6e/16E+2Hs8U?=
 =?us-ascii?Q?hwZIqCADLaIJmD6GB8RphmE1KZ6jxIepkVHtrw/DWdsuJbSKnBgF/SSj/L0C?=
 =?us-ascii?Q?J/l9S+jbWYkTNjqZvpfC6FewDf+CfVrkxph5TnmCNHXXsr6bZWJmAQQg8vZB?=
 =?us-ascii?Q?qdzB5hBBnn12VfjTErxGVinivfTKJf2dAF1pNLOeuMN+rUol2XJZE4Pn14sy?=
 =?us-ascii?Q?Yuf2FVETXBv4okz+TYW9Vz6+XrFrHW/EyYx50zTJriZZ8N2gP45ttWcB8O8H?=
 =?us-ascii?Q?X5qI6I3kDJ0Gclc0Civ0fULLzVS54uCnwihfPUURILtVy4L9X+ctUIoH9KHI?=
 =?us-ascii?Q?QwMMVGVjTzHiDJwFrPhNKnG4fIvxuHcceYAiEEG9sC/eH77+4FobpKPmKzD2?=
 =?us-ascii?Q?BxRGLpOiF57RYuGUYRzTzdqyKDAE+o/vPlMA5p9ylGnZXsnyl3VKeMJQKMrv?=
 =?us-ascii?Q?/qZWllaJnxFb4WgjdiXGo1faYvUbMrzNf4/vDZSpB6itCGuZoGeY1T9C8khs?=
 =?us-ascii?Q?UZHfkNx8vWwBVRPNDxgWThxqedEAo19sQSK+20MIhVpeRczaPvh1K9l1w50L?=
 =?us-ascii?Q?ofvIBOO49HwSFbp/3619fAutDzFPDYrS7GyELZYscOzeu3NxZqIk2+zyknk8?=
 =?us-ascii?Q?beED05C/GhXhv9zTLRMfnnZqhpRITRnfkQ30sjkl3+ugHbCQ9EnioDXekfx5?=
 =?us-ascii?Q?HMJSyAWifBnxYsQEA5voQjUglRYyXmZnI5kgkAFwbvtm90BleEc6CrOCYKdd?=
 =?us-ascii?Q?C+OjSviHLiCXPwYyGFIFO7UdA3AFXc1oIP94aIJHc2yqfzIfiinbcz0G9Phi?=
 =?us-ascii?Q?6kwAgQCS4+FSc5OACK3YI0octNEvwyhREAtyBa/WD2sKsmKLyRFHabuLjkFi?=
 =?us-ascii?Q?UrYMQzIMDwL+qEHVGiFQkMBSRsjvb0Gu1Jk7m2asyMkpm//26VoshDfwXFIs?=
 =?us-ascii?Q?rUCeaU//fDmIy20REZc44eblBLZAIgnu6wc44QJHEuTxDwSTQIDKvd842cje?=
 =?us-ascii?Q?qAfNXNxueuxN4+p9tnpkv+HbI4EdnnXrRQXk+PtlzbM9xl1+599UjMqEsJOr?=
 =?us-ascii?Q?AiZE7F7iiqsLygaymrYhgCt5kw2TrjQvAl9Vklbwr8hnldU7X2iCpj1JwRdG?=
 =?us-ascii?Q?VvY+ud8y6fDAUjzCIMqWPMb79kgISzvXQlHlaQOqyl/01oEAcA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ad71atCoApHmL43QVZBtr6sbY3TBI6IvFrzkkmrQo8g3u7Q+mPplNCVlftzL?=
 =?us-ascii?Q?qt5jw3ppJceJllZltYDxqM99Z0C6CW7jVJ/R1a9SQZraZeuiYeQKvPicBn/z?=
 =?us-ascii?Q?/Labr/iFhbtcyyp2NReeQ/KMTHwr91XvU2d7z7smo8kze8pIil/agLQVVtp1?=
 =?us-ascii?Q?9UMb7gWpeiwDj86lSRRmkAvk0K7mjqgISrwMnsEr1jI6mEhjdWHpavUR6H2m?=
 =?us-ascii?Q?532BK/OMXQ4PIGzggF/v8PB0GVK0syPAtt+PRgssnbGLhp4R0raFbfJHUn/R?=
 =?us-ascii?Q?aY+cY3a8svFflxdpCVyFnevkv+dT+NvcKL42IdrhRHfq3OJiP4332XRGjHmS?=
 =?us-ascii?Q?nEGBf/BeP7OxBuLz9/02dSfv71Vr+V6z23pJTIWkaYf7WQ8xOuaKdrOA6K2Y?=
 =?us-ascii?Q?C3ZEaNQc9bKHmVT+5msMYsgIW4UnL0V+k76J6PvYPmTtiE8c2aAV/upHnHqk?=
 =?us-ascii?Q?RaBLbWJViLiqEX5GY4b1WUzYs7wf0n2FyBKd0/Px6RUX9p5z2US1/+yjazvy?=
 =?us-ascii?Q?xly15Cp1SoGWLdwTAp8pn82I2nXwD55VZJDPZydlKlHOVvTYbV2c5+8qF72+?=
 =?us-ascii?Q?9WTrYTrYw1WJshqjpRsrL4bD3kNZpHN8UFZn9CRcP83igXJpT5XocQaQXlXC?=
 =?us-ascii?Q?NfTANcYEqZHBmzTtFANuSIgLax8C5Turfrpk6jtCuKR8PeSFoIPpwC47Nolg?=
 =?us-ascii?Q?u7tYQ5zzx6J/jcjRvHTogzWmT0h3EaFnkW5k2N+sn+MFfb5qL+/40p0HD9JQ?=
 =?us-ascii?Q?fQ6i/QmiGOuCeP2KH/bP7v9zNnps5BiWgkZlRMaOkIy2vFz+jlt2CUKhlV0G?=
 =?us-ascii?Q?cQrhM0FxPZHYKalp+MOaV+3T49IODiivS6TFNuwrRPzc94fovHAZUX0lHEdA?=
 =?us-ascii?Q?fX6FYILD14G9QBJmpUzswLJw4L139VoWyuS1PwLXVKDghxKRaqcMT6yZq/YV?=
 =?us-ascii?Q?NiiJlsYamao8xAoWACmqk78cSG9lWJ7oHePsCiDnYcIo89sLCNsChXNZxkMv?=
 =?us-ascii?Q?5z9rXn39XKllgLT/OFkpOa9+SeoFImd6nK6kKNosgjQA6d8WZJJA1tyb1ln4?=
 =?us-ascii?Q?tSS4Kc62Va8ZibwHnqoz80oDOrRkk8Wan4UaT844n6oGS/rdYxKr5BA9LoI7?=
 =?us-ascii?Q?4sUyJ1AKK4lg8pe0OsUwCLjjlIkwr05G6Y9xTYkvyLgIcjMXwNpthzURBYje?=
 =?us-ascii?Q?fSarhxh4MUtjiV5l+fh56P2xT/bsIIg+csFOJmaLi0nphg/vHKZlURAbD6Mf?=
 =?us-ascii?Q?7d6PZ7R76Qj7Z+mxLpbIcAgZhr6tq1W9MgemtbJjQYEVUmEGjz/pll0Uyr6z?=
 =?us-ascii?Q?rcIjhhhhwjKgcqWeVzApa+THtswthHeQ4hiyPvxVgoKKFURzuhbUWgfzJ6Qc?=
 =?us-ascii?Q?z6OVOUqkg3IGhitljip/fkgzmjik919rcqLrXKgsT63neift1V+873SPfNta?=
 =?us-ascii?Q?dOltEQMZrAt+ShBS9WjFKoqAeOTgRDj2gW5ElyZg3zFP1FcuHAgOcZAqMcWS?=
 =?us-ascii?Q?S1hCV58ERzRXlKwNgYOv2zObgX3QGH5eT9+fsJyJ8KZ3JMoEBdNsGVzCu7fz?=
 =?us-ascii?Q?M5zJvSusbWBQXn54AbdWVU9V+xj6WUkk8tbhtHd8TwsK34zHS+ltZZDbAiaC?=
 =?us-ascii?Q?s+J4/vUALn0nkN5u2XZkzHg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6ce59-85f1-4db9-2094-08dcb00b73d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 20:17:21.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMCppT+Y61KWM4JypnYGdK+7UJBe1rt8PorYq18LciBLP/EMqS91YTSANlkSGpspqlqnK16R06Uv16olxJaXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1498

> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Monday, July 29, 2024 12:57 AM
>  [...]
> +	/* register the callback for hotplug CPUs */
> +	ret =3D
> cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
> "hyperv/vmbus:online",

AFAIK, Hyper-V doesn't support vCPU "hotplug" for VMs; it does
support vCPU online/offline'ing.

To be more accurate, I suggested the comment below instead.
/* Register the callbacks for possible CPU online/offline'ing */

Otherwise, LGTM
Reviewed-by: Dexuan Cui <decui@microsoft.com>


Return-Path: <linux-hyperv+bounces-10400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNeYBn2072kYEAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10400-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 21:09:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12647912A
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F563043FB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3C3EE1DB;
	Mon, 27 Apr 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZOBy950/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012059.outbound.protection.outlook.com [52.103.2.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF53EE1DC;
	Mon, 27 Apr 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316746; cv=fail; b=OveqiV+q83TtdGLFzqDIsC5mCMHseRUiQ7+6YXvFzInw3YcnRnQcRJ46acOECYv215HV7o8s/l570NpLOIyzL+DbiFg9v924pj5IJ2NFqZSVzR7Vr8V/kwgzIk/dfJcKYWdYLZZXNHd9NBIyr1RYRNeXjvVdrjqAGTxJ9gHWfsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316746; c=relaxed/simple;
	bh=EmuTdSK2W0NHXaJSdJUYToCrq6pjD/lXqEwdTyuHCOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nU8SWgM4SjK08sFsHLMoqpItH4AsD5kBsLeEmfC66wy35bthpB2jD3lJUFqR9ONwHpQP8LSsoEMRTHdwfxOBPtQiFnwxL3sP4HwoXvNtaeBxY2husLFbNJHxr08nsmKIvsIHCcPqIc0yxhKEQ5jvHz8VEc7FHQn8ycepgdm67qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZOBy950/; arc=fail smtp.client-ip=52.103.2.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa2lqthf/URhID4t+h7OUlA26XEwEtKNBs5c96GNKpgxXmRH4O08SIpUOGBlfvX9WKWUom8a5Z21H/x9opF88cNiz3xkS6U/yUCKcIZSqjCaPeflSfl+PUG2qLmKn3phmjm02sKIcgrFkBf7Rq5o6XZ9/mXbp5phNyBZY+FimLCi+xs/U1gZCVO+/lCculYc+iTOTyMj94adKXB7FNHaNWFuBpnXpocc1QUUHCIBveuxKlAp+FV6zKRJlsMLFW06qDPHeUqR6EFOGQ1STxNYmqD7CNojA6M2jfhK0iK6mKlVcXsFMD4QjRwbwai75+GzxGUY3NE9QuUQj3KsGH5kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6WUTDrIpNmyQzsep64+q6k5/jKwatOHn3bJdK9djvk=;
 b=hxHLJodaZokR8AclnlASoxvqGnY3BKqyJvmbLFOZLHaKmf0HDP32SAKhE2rfRU45SJPQalOzfeyQWwAiFqHDFPDlp4Kxv2seixkpuidFtrtIirQ6G7P6ZwotvhCqTTquYgPupUUSteMxsM318ux+yha5DJnlXsIHw4P0CrOC9m4aYvEaU3oH/mHcopNWAoM0eKx9lI3VGL8Q7LAPMiNhHpTk6tXhNwGINoMpXJ0NrlKmsh4BbQFxJYevjCnVKbCROOUFdbXYe5oAeDD0Fiw7z7bdvi3vxirPWJfpDF3BsIk9Y5EFGeZZzInca1JeMfVg2rjlCUWpFSaWWQ7FOHAnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6WUTDrIpNmyQzsep64+q6k5/jKwatOHn3bJdK9djvk=;
 b=ZOBy950/L06xypk47360r7dNPULEMuMPK16mUtPS2zCdkqaGkUrZ1cGhVsrFTvXenqhP8WOhIVOc12y3qp6hzY/3P6EEDSGQlEiz2F/TkWXARH+NmiKCRdY4xxjLFab0uVzlyF2MYlrG9rvlTG8eF3Vzjp010DTn9vo/H06UOcetKH2w21LI+bsWYb2XwQz/o5IWNVtGzd3kEpsLrlpR8oOCvL1gro2mWhiFy8lPHiFyIVzjOqR9akQX6U+sVLkRTNRn+FgTWm2fV6bjfedfACuxTEj6X/o+rIK3r04UAajJJcwR97Se1/VWY5420kY6nMo469tTzBYN2pMBwmGMrg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8422.namprd02.prod.outlook.com (2603:10b6:510:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 19:05:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 19:05:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Hamza Mahfooz
	<hamzamahfooz@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano Garzarella
	<sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Himadri Pandya
	<himadrispandya@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Deepak Rawat
	<drawat.floss@gmail.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "stable@kernel.vger.org"
	<stable@kernel.vger.org>
Subject: RE: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Topic: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Index: AQHc1N/oW1x+JxhWuEuJGiYOCEgQVbXwyW4AgAIFNgCAAHLMgIAABMtw
Date: Mon, 27 Apr 2026 19:05:40 +0000
Message-ID:
 <SN6PR02MB41571A5B77A5FDDFE17AEF19D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB6921B5A2441DB3E9A1312AC0BF362@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB6921B5A2441DB3E9A1312AC0BF362@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=866de344-17d1-4da0-ae37-df720ba729ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-27T18:37:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8422:EE_
x-ms-office365-filtering-correlation-id: cc9ecdd9-e3ba-4b65-a5eb-08dea48ff942
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19101099003|55001999006|461199028|13091999003|37011999003|51005399006|2604032031799003|15080799012|8062599012|8060799015|19110799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RSabT02Dj/D9uAvexb26j4dAscQPpYbPAtThNO82dk2RFjITzHY1Rhf0o36/?=
 =?us-ascii?Q?M9500fBtRw/7JqgxwvMRdbk+rGmX1U2l8luXUj88aWii4bVqZPtHaua7h1Qx?=
 =?us-ascii?Q?TVZQnO4Updu2HtwfvANFx+4Kg9jN+23oNhOQAeTa+FN+Ya7NzBgFLiB5X5yg?=
 =?us-ascii?Q?a3+SmpcOObn2SQA/5HKVn0Gpvo5XFR2NwizpYh61rvjVf4UvtottMbzMiQlB?=
 =?us-ascii?Q?u9sMMyLhKMNfQ3rlT74fW3AvWFv5U9LLU3fS/9fe4VHH9LVPmi9FsIje9/fd?=
 =?us-ascii?Q?YWYqQas5rODrq7A1aEo6f16kh99l3gjgSdNxipBcQBJo660fCuvRRWTa+NSn?=
 =?us-ascii?Q?kSUHw+go0cilOSKDI24drT7fIQR+9knMO8r9oapnn8vKIyZuWNO3PxVpuOFm?=
 =?us-ascii?Q?MWKe3HeQcrKzWXCqZXGR+DiF3Q7IpBA63BN/4/NgejrKWQDO8M2DQ8WVCzeZ?=
 =?us-ascii?Q?oKdXjcMqo/djVq40wB0hj8YaJ13tKRwLJlGQESRLa67YvhZlCicHGxAainfC?=
 =?us-ascii?Q?DR+W5JmJ1U2Z7aNukLwdH5R0nVee/7ceH+OAA0XBx/oejUbohINa2892hoia?=
 =?us-ascii?Q?phpuBRgSfT31sRnDiOuMFV4DYRnseb8tYrgdW/BmqvtXzZJZZ6k6l4ZAeNmH?=
 =?us-ascii?Q?N5pmZEnXtlRMMEhXsO3v2k7TcByavV2iCI7Lc6VrqRSPWvFuaQaCmVwf1ZZu?=
 =?us-ascii?Q?Y/ocVVS09w2t/p0wncXxHhtPFA4oW9rJtBlEpL++XcilV3c8+rsZPi1YO4nX?=
 =?us-ascii?Q?87xk79e1DnAUJ3cAgsVTnBTAYy/dDmpl+Y8/h1+HZ5cgDFdXDK54KxpIiuXw?=
 =?us-ascii?Q?uCwwJijRKwRF+RgV0qlck9Wmjnan2HdRK7BCgtt+1mfgkNfk1Ro7awgDJrZt?=
 =?us-ascii?Q?BjiLGPeYdp0NXgtw5CBOP2QFwaeUofQgyxGNTu+Vpn3U/e3MEKwSy0EmSvDo?=
 =?us-ascii?Q?wWXTqYeAFmLcgBU9fwJHSY5Y1sMzkkIydjpsVuW83jrPKBjP1f1rEqOli+2r?=
 =?us-ascii?Q?t+QuEDdaSoRuuMWDzRxcZ+03q+z9ViSm80rXE2QnvBjSPqNlQUl7/16fTbu7?=
 =?us-ascii?Q?mAL6QxyeBXUPuZXFx+yDbVj7inlMHg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pIXvPSkF82HKSOkv9Vb0Sp3kWex3bjEv85oipGCaeT1kJZnqV0yD3Df9l+hE?=
 =?us-ascii?Q?RlTQo2n9jgTVIHEtQ3Ssa5gj4zZdxklHSElqR6WjMB2F2m5/HnMjDJNW1RU3?=
 =?us-ascii?Q?o/HnLkBFA3yurBL6oAQfYwS0XftrMI/HRcsjG8mSSpRuU8bMxCsawrt0F3vh?=
 =?us-ascii?Q?K/282pDd3yVj9rcDCUvwcdNU87mmCs+AdQW00ur1pDQXr7p4H15RpeVJupP/?=
 =?us-ascii?Q?Rqsd2BVpkfCn29eZjlaXwWB03y5rKlOZ4l8+C+X3cCVaVZEQ9XjwjcFRm8CX?=
 =?us-ascii?Q?6eaPbIJhbXfvgBKCmJ+mk/ho7sf3pWLTTLBgwqQpX1NIuI7LdcoYf+XxfEWq?=
 =?us-ascii?Q?h5iUhinKBbHBLLOCZ5NXyi3HLufEgk5iiJm1Amt6PBE29IRCo1UjWNZCyLTV?=
 =?us-ascii?Q?gI3XVoPDXaXv+Oya8NVWc2QuajEEk6nhr107iOYE1rzto/ZHH9BDISd1kcET?=
 =?us-ascii?Q?wZ4+IKSww/P+8Q6eMgOwEiQCOCDtzuYEPLyF7uNR67QC+HvOcYbjGDlluYKw?=
 =?us-ascii?Q?OP3pgA4lTfrkHN6+z0L3b/B7Canff2jG2kT7PCyHSdxOs789c8pfAl9ICHH3?=
 =?us-ascii?Q?lYDHDPf1M8dJWU5Fpxpu6YMbZbt1bIa7Q15BHcWLZUsAVmrgv4DZORYANshV?=
 =?us-ascii?Q?gXNK5c/VQmXsSN/4BH0temDNUaIn1aVQJBY0WUcHn+niwAez0GEQfc3BWKXe?=
 =?us-ascii?Q?CZjXDLoqEcaIATX7PSpl9VjXNW7I/IQudwlsycl3ZqUKnqYnZ3I2L9XingUn?=
 =?us-ascii?Q?hY/3tKTfjSBiSfAGq+MhTw3t1b7JvNOLhUCvjNoKi6FlUznYyK2QtUc+eS0e?=
 =?us-ascii?Q?aW+dVRzXMpzA2835xdv2sEF02r0/+JV06XPHckzMY/Kutnz+On49Ra7cqU5/?=
 =?us-ascii?Q?A1gK3u1LgWhO/60Mtt6FCBaveVg4qozuzdXOY04CVzam2P6dm+bU3Cf1FSrF?=
 =?us-ascii?Q?hAPe9d/h3r1Dk3DjRIEyPkbbTb51QHxoDqMo0lsu5IPHoCmeTZu2oMuiY7Gt?=
 =?us-ascii?Q?mKmfkcszXdegPW9VWHDlyMycu67sOTnh4Hkgb/o4jeDU49TUVSeFzpqybJtr?=
 =?us-ascii?Q?otLqCJ1h2iT2xX16fElhIWRRhtp8EMY6W0FWrHreQntHpbh4IgEuxU3ilyVR?=
 =?us-ascii?Q?Uf1SHf9pm/vYXJXZELtDOh3mXS85gV6gCWGeteuBedYPbKO8O15i4E79z+6H?=
 =?us-ascii?Q?eybEhXscDKwpxh9MFwU8bF+q297EZvGiRPT8uNhGGSu8Vp7L1NkTi4IG9ALx?=
 =?us-ascii?Q?CVmcBC+cTTkSnByhJtNgufiBO4l1IMhoGBwJS8hzd7Mb5OS8pbCvVZdz3Wad?=
 =?us-ascii?Q?u2atjw4qlRUUyzETozniGcdzFhzCBpmwwsIkTXkRQn+BgsZiCRB7A9haId+5?=
 =?us-ascii?Q?IQXeDqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9ecdd9-e3ba-4b65-a5eb-08dea48ff942
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 19:05:40.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8422
X-Rspamd-Queue-Id: 7E12647912A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10400-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,vger.org:email]

From: Dexuan Cui <DECUI@microsoft.com> Sent: Monday, April 27, 2026 11:42 A=
M
>=20
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > Sent: Monday, April 27, 2026 4:52 AM
> > To: Saurabh Singh Sengar <ssengar@microsoft.com>
> > ...
> > On Sun, Apr 26, 2026 at 05:00:24AM +0000, Saurabh Singh Sengar wrote:
> > > > Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
> > > >
> > > > VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() =
to
> > > > ensure they are always aligned and large enough to hold all of the =
relevant
> > > > data.
> > > >
> > > > Cc: stable@kernel.vger.org
> > > > Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthet=
ic
> > > >  video device")
>=20
> IMO the Fixes tag is unnecessary because the existing VMBUS_RING_BUFSIZE
> is 256KB, which is already aligned to 4KB, 16KB and 64KB.
>=20
> VMBUS_RING_SIZE(256 * 1024) is still 256KB.

Not always. If PAGE_SIZE is 64KiB, VMBUS_RING_SIZE(256 * 1024) is
320KiB. If PAGE_SIZE is 16KiB or 4KiB, then VMBUS_RING_SIZE(256 * 1024)
is indeed 256 KiB. See the explanation in the comment for VMBUS_RING_SIZE.

Michael

>=20
> > > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > > ---
> > > >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > > b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > > index 051ecc526832..753d97bff76f 100644
> > > > --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > > > @@ -10,7 +10,7 @@
> > > >
> > > >  #include "hyperv_drm.h"
> > > >
> > > > -#define VMBUS_RING_BUFSIZE (256 * 1024)
> > > > +#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
> > > >  #define VMBUS_VSP_TIMEOUT (10 * HZ)
> > > >
> > > >  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
> > > > --
> > > > 2.54.0
> > >
> > > Although this lgtm, but this may change the behaviour on ARM64 system=
s
> > with page size > 4K ?
>=20
> Actually the behavior won't change, because
> VMBUS_RING_SIZE(256 * 1024) is still 256KB.
>=20
> > > Have we tested it ?
> >
> > Yup, I tested it on an ARM64 windows machine with a 64K page size guest
> > kernel.
> >
> > >
> > > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >
> > Pushed to drm-misc.



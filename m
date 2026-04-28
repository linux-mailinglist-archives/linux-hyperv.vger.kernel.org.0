Return-Path: <linux-hyperv+bounces-10446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBokLLIh8WlTdwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10446-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:08:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F348C38C
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5BB30254C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCAA39479B;
	Tue, 28 Apr 2026 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IZN8SsoJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020088.outbound.protection.outlook.com [52.101.193.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C73914E1;
	Tue, 28 Apr 2026 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410480; cv=fail; b=ZQFX3J5e8LMvCxLlKXywe1OhyzF6Brvm8sDcgkzMUsLrpuaU6oJBZfNR7q4K5NGdSkUsa+k8nQGTXdcg02BXrSBtNshczT5Pa+epbBK6s5d4qUObi+FtLXPvZBkll1df3FRvCUG997RjoCzSrIL6oJvkOuYGBjI3cUY+Ob+zk+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410480; c=relaxed/simple;
	bh=HvREIdF0raYVWl9lMzzTEs5OCz7QphVfdr3KxHX7Ato=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KlSnWfjiDv0iEXcq8GiZU0ynF/YSxpxzRMRC8l/1KIFMyriGjqv/zc2NN+6NMJ+R9ckYIxhK9b3QTqZLi1fiLWgUORwkxKJvMNF/DgZcxpPwv0lYJf24lfFIJZxkGZ4JP2OqUesBCFfooiQmSjKQwyHi4aumIF0uceDjpcElrAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=IZN8SsoJ; arc=fail smtp.client-ip=52.101.193.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJMzFrsY+Ax7AMHzxd8hzCatBDwJk2Lu4n6c53ivZ6TlJXG78Bn1Vn0neMlF9IcqbXdAHTNq/sii2yZUavi+TmyW/svph4zLL6NBYT5p5QSUzOYaIDd7C6Y/WduMXdAUOBqRFxc2gUgIPwuA9zuhgnCJcz3PKXb/tmR+xPpOtTlW8sGZOiPUj9iSpY3n8m2ZM3YMszyhETjryWpWDkW460zwC8Dg7pv1IA3kEPosd80udTHaVEEbF2fPnA7aTGBYpPiGO5+691+F+1VbnuCAO7rhshQsD0klVuBSIPBAnmo0hwVp3POfspfQeejgjGG6p5q4z3ZAyWcnozoAVVWkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpgwo3alVtQqMkcyNFrX/BUD3guXGeSSm/pNrXmMvYU=;
 b=Z5cvSTN+Xgd8Hbrb2HItx89wNxYAcLyWGrNxcssheV7sjGtdUdVYTNG7xHaKkh17QWGMpRTT5eD4hVzbZD+yV2r+HhhXrTQVrpvjkkRB+BEEQa5r5V0q19HmImV/sY0yZpzC7rZl3hPHXwwpN17As2M49zNNgvM3cnV3SW1h0uZa5e3H0kN4w/ozydtgobmy6EiZZu0uMh6cYJ4h88QM6oOwyfOZgwdlXx9T6a9l/vfQm9bsGO1GwW7Wch3MHd44JAztIEd+pDcya5UwpQcTRfdxYrWxAF6+wDvQCa2acnAqGEZZs+xeWDNQAhVnoKN9P2YlRXFurXs3QbmvAZpwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpgwo3alVtQqMkcyNFrX/BUD3guXGeSSm/pNrXmMvYU=;
 b=IZN8SsoJqRovCWIDB+nz2DU7XUrbyL/1Pdz7ikAORtMfM5dWsSYsaWM37PYHJP3zCOp0AWLNVBt+RGOkDGWZgn8El//kS11R6k7NmeohczbzZEb8vzZKm3JbrX+QKoTLfKITde1A5z7lGrI12CbKzw937FxeQz+1BmhGIa4yrfQ=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6417.namprd21.prod.outlook.com (2603:10b6:806:4b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.2; Tue, 28 Apr
 2026 21:07:53 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 21:07:53 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Himadri Pandya
	<himadrispandya@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"stable@kernel.vger.org" <stable@kernel.vger.org>
Subject: RE: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Topic: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Index: AQHc11MA2yJrERFkmkeSl7gccH8LxA==
Date: Tue, 28 Apr 2026 21:07:53 +0000
Message-ID:
 <SA1PR21MB692119C0649074A93960C181BF372@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82a2108c-beb2-4494-ba9e-f3986276f437;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T21:06:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6417:EE_
x-ms-office365-filtering-correlation-id: 1fddf4f4-ac05-43bc-07c1-08dea56a36c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 1S0bz0TzmIaPmiUbq6jum6ZJKyetcdy+1xpCP35cSzvIS4LoTHLb18KUrHJ/Oz/hDsuQdHD07Npn8EztceC7MJjv+CYvOW09WQ/9R6WNOB9tFdSzfjosZdu094bHJclSoxqlQWHHYx0Dy16qTHYw3xT+br8SOEmAaranxMaMAADOoQe/J754JgLQYrKUbtN576PGHgYGioSJ2baKQVK8Y9gwOBseylybgoDRF8b5JxC5V7ewL/e9PhtoMmnyWYMvaEI1tnPdpjvJuRypXpScMRPamv6Ay0IvlTrZ3MmprtAtyAIFisVcpy3yqxxkkpzfYJMQiqpYTE6xDFu8lDqEN12xJq0qgdtjaVdSetQ1oGV+EngWodihu0hynnOoIVxUsPF6lLmViKPFDXD8wYyUBvzsLJBS9r5eKm6l8gaYRP/wXOkLWXdGXakJ4zvXkb2qGEZBUYfCkgI75/OFnSV5PmBVmsxeU2BhnEp9TzlJfZQVByLOzl7+HxgHyVNdunPZlk4X/Gyvvc44psgflvaZZ+AKREhl8qXqe63sz+FFuPOJujlyGPdBjDuoW+qpL1F5ZBO6ZB7Y/24ulvVApFmOycDEXlCGvjShXoCq0xfLYnzIwJCqsKNLbYGzVP0mvzEUFe4/lq83+kCy+JP8Al+2g9IKAdMZwKAViJpXdEsNMgZ/xADghgDNfk8kS0HnkvJ3Bc/1JAWKTxRIcVxVM0xu8MBpfF9ePmj/S8b9Sv4krnMd/Cn8QqOhV6ixwh/HOvTLetuMGGcgX2OoARjC59i2bw0nJDsii4YX4U4HH+UQtLM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rtz78kodXRE8AJd7gEl7qRWvBUwBk+1bX0boh428TNO2mLTlGKFlcWcwSXza?=
 =?us-ascii?Q?i7QXHwE0uSgM73BNKWEPC/n8qALb98kHTw70hQha0WZ08pjEtXrHGQeJkQtj?=
 =?us-ascii?Q?Me5bvJn0E0nfYw0ftg49PLaFZ2EVIAVI8W0hykV8vyyyRviKMfXz4kFZwpft?=
 =?us-ascii?Q?6ZeWPx5YHTImVlFud0dL/1KUQebXK8ejIzKiaiN0wD7DWuiLwrYszpEGP4Ev?=
 =?us-ascii?Q?VH77hYDc28CpJj1UeJSXvEIfVFaH8Dv+RLZfX3l6STwI88qGL15ji9UtgtIm?=
 =?us-ascii?Q?n7hBOJq1UF4C9HGKCKx5F0wAd6z6bbOA2/2KGVa2k/W7LyaRVYv7j8Rf525R?=
 =?us-ascii?Q?DJvyNML0F7IZY+ivkIfszOuqzflnlR6QQKEnCrRJptgjU4rll2XDxVo7sVzC?=
 =?us-ascii?Q?rNrcQTeIw98DVDSp6hdxGNh/utpAOdI4WC+DUGc8TMex655g9T20bkmhvr9s?=
 =?us-ascii?Q?bPr3VpikQaiTLZ47ddKhRZMlkgszP1C+eZavsA1xCzaoCyosndJrBPDhSwwa?=
 =?us-ascii?Q?w5kptYXZxiNvyvHn0dkrXc+6AyhXBCtj1q57T4AuXlG4iOuIWs4yC6w1SgsL?=
 =?us-ascii?Q?+K660xLRqjwUi/c6CJOeD0cdZg9YHELdKM+73ykyCfQ9cZkPGTx9796HAR4B?=
 =?us-ascii?Q?Q6eiq2llSaRcNv0pdEIcPNi3EIW6vO/zRUGP65pmm1U8HCQveHh02jLOVDKr?=
 =?us-ascii?Q?44fYNcj5wTB9D1T+QdGfZBBS7NwfHAORYdV4FfhRma1dCIJYdbTtb9OwzOcN?=
 =?us-ascii?Q?K0YhjmEO+sQOIaB93xbds8RCkFtpXwW3qYtM/4rHZiqh+TpYD9wf8/F1tlgX?=
 =?us-ascii?Q?8a9mbNi9mPZZwtQJaS3PDka1rRV/3K1VtxHLKIHlDtDfxkEQzTYAjE4RstKJ?=
 =?us-ascii?Q?q2tEyH6VrOkYJG2f3Frlz4jx9Uo+90oIno+O7AJ+dcjs8017B7sjrh8mXmbN?=
 =?us-ascii?Q?vMbi5fx9JyftWwfgi5INTXPDvupjZk2+aQptxXEUsw3SR8VuPZMHuRRx/dOC?=
 =?us-ascii?Q?8WM4TNDZBDt7nKqXhJ0w4nuIqPO8QBeawqFARzj1+WWhJGwIf0+bjhORo/mm?=
 =?us-ascii?Q?oXd8+rlmZM6rsLpaIRcK8+kBo7pxWa1b/nhDqZoVaar0G5mwHv9hVOc/507y?=
 =?us-ascii?Q?rcxTq/YqbaN63jHP5LcRxj2Sl1c24n/5ao85LRRzFLjn0dB8WHqeJGnoyjyM?=
 =?us-ascii?Q?RlkROiafDUHwxS1dwYHKQTeZNKWU1GvQS3kgEAmo0CYPX+X6AxZ7RGZIQRyE?=
 =?us-ascii?Q?XbI/yuMY/u5DIr0u7u/YlWZPHPhkosPg8ecs9xXqZWkH/cUZTXPh7SPiCZxW?=
 =?us-ascii?Q?wYaT8I20hDXnRfFLXa1GmU6WBV33SR9UkYmZmZeMZPWGoukSyEC9W/kMrIej?=
 =?us-ascii?Q?hoNrAC2vEaOZuzZWpX2HqhdQ/sDw4mi/tjN4rxnA3eCOjI3UV51dTLoBlrn0?=
 =?us-ascii?Q?vRBEqVZQIypWPK7G+TD24uuwj996MkeGrcHpRTasHQpyg4ihTfQaSupiMQ2X?=
 =?us-ascii?Q?Kvd+h4CP3wvEX3ncxwnRUG0eVR/vxg9B4FOUX3L39zmoZuNhLGETP1+yspLc?=
 =?us-ascii?Q?8lzH3RvB3kMBQrHzz7nqEw2BztZvQ1ik9q1EZZzAgYt6FocW9YvN6FB0wiRc?=
 =?us-ascii?Q?F+G0pwFq4WZ56rbryv7/U0zqGVOfockCP7CM3uxkTF8YfyUzExdcWUi8EbFZ?=
 =?us-ascii?Q?sB6tbhGQNF7IUL93IElvig5YmcxHrs7XR7N+te7Q9pIDUr8S?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fddf4f4-ac05-43bc-07c1-08dea56a36c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 21:07:53.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8H3E1rywbK/UCx6tnKTUqzm+HX1bCreBOZs959LEMzZbIlOlfv6lN1+ReUzeF8NNFbtdyBPCyK/GUnIB72HARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6417
X-Rspamd-Queue-Id: 1D8F348C38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10446-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,outlook.com,vger.kernel.org,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Sent: Saturday, April 25, 2026 11:17 AM
>=20
> Cc: stable@kernel.vger.org
I think this should be
  Cc: stable@vger.kernel.org


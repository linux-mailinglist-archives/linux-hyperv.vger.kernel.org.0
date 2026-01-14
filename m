Return-Path: <linux-hyperv+bounces-8291-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38089D20D73
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FAE3096702
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03183358D5;
	Wed, 14 Jan 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nf1Q4Y8p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023133.outbound.protection.outlook.com [40.93.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED28632A;
	Wed, 14 Jan 2026 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415275; cv=fail; b=KUfHOy2D+8LTFM+/3iFjytLAoP7/xBUcEGVQzsWe1IsuhKy+THG/l6dTiZe89OC/RGbztXzOJhepj9iOIS3IDpPHh4SWGLL1OED3eheCC4E/ILY5JDLXNmVO9iinQg6J5AfwxSrmOUb1kctZwEEuKS6te1QkN9LvxrPlkYcewoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415275; c=relaxed/simple;
	bh=nna3hOhYwDdQbcts0Uxwq6antfUgHrltduXB9Nhv5Q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M9Ktp6wu6FuksXZqzowq0A/6wJczTPg3ZuqPwfWgdnOmtdkcev45GfaTWYsASKVB7GqoN1qFXVFMqQpY/aOLuX9aqj0kGkV3rDF+A6oGDc8QietacQURnVQ0cwwnlA9yAz7/4RRDXvjcqQ9t+SVY65nTpkXbdajJfQ6DQAnKs8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Nf1Q4Y8p; arc=fail smtp.client-ip=40.93.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHC2iUnA1mFnhs9u83zEJRPPnCs/Eg+0rmRWNWpo74T6TSkhC/PV4r3xndjdvGL92sSOd/0fb7/h4mQ3rcBvRG0GzD8twOKHq1v/SPVhVIAYC9wHzlA+AYUNE2z1DvGDBVlu2bZ3MhDMczWy9ws5+c6VB0dtU7h9wCKSG2QdHaDv7iWgxNTL9sw9NOkU2MgFbCQwSKsxaoIwbuGz0YL9grPav0l6Sdu85IvgzUQoD2u0GJMZvTxiS6rk/AVnFLynghYNtPK+ewaQEmldB16vLDdA6m9pyOI3vG0BD7rXkHcLw875A8jzZ6gFwVJUVtKS86lgBlIjCzNbcpSGccDGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nna3hOhYwDdQbcts0Uxwq6antfUgHrltduXB9Nhv5Q4=;
 b=jhCjZzVwshL8LhftADdGMir0EjU8BWzLbD93SQruNu4NTyIIXnog6H4XTgTkoLeA8So7IVUxkv0AlBxyRYMArtGLTkXOpuhFEWh7e8phLJPVJ13Bd9NhhPxpcc2r36JiDLpOIjiIlV/Pn9hZhl5RVXFFC3g7lYQbO+giVfpKgXh6ijolJOR4qbwak7xULAdXN422tmVkHdxl9FJc4o3E+h2YT/+z/4JBqjwWCRwp4OOObHA0q9V3odSZ/U5xWjyELY7YsQXYKbjwne7N7GjU+H9e40pt8iqcrHx1lnPfrnRUSEIsVQAt3RVkX3ZKgSLDp6fdG1SOo8mDJ2Dgtz8aZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nna3hOhYwDdQbcts0Uxwq6antfUgHrltduXB9Nhv5Q4=;
 b=Nf1Q4Y8pew7B6nUasCOSL+ljKibJSDPf6HqINC1ZbQ6wNPfoiP9AtHHwA9I4Zzw/2h2lQXe1ISgAs8gechhNtiruncz8SFvse+d1nuzSKi2NFpM48CL3erM0IUL4WvnqV76rXPWY6q5oj/b+jfj5AESXwJwXYHy9C1Wvb965W5s=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by DS7PR21MB3268.namprd21.prod.outlook.com (2603:10b6:8:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Wed, 14 Jan
 2026 18:27:50 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.001; Wed, 14 Jan 2026
 18:27:50 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index:
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnw
Date: Wed, 14 Jan 2026 18:27:50 +0000
Message-ID:
 <SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260113170948.1d6fbdaf@kernel.org>
In-Reply-To: <20260113170948.1d6fbdaf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87c43b20-e119-4fb6-b457-d6d6ff939706;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-14T18:23:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|DS7PR21MB3268:EE_
x-ms-office365-filtering-correlation-id: e4688d51-72d3-48cb-151e-08de539a9fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SNz4XIGScOMCYfNJMfwccqJsiYJQV4Iq4CRa0dCrApopgusTAWZchgQ7fxSz?=
 =?us-ascii?Q?fLiAZvPSMaScKmYK6+8JX96Wkgttum0ffH/AKWpvz31hrBH3Fjg2E7eluw+2?=
 =?us-ascii?Q?pUzflL+5vgGhTX+cYC+ar1P3X0TeFe1uA9H6CkyEPRLGEBV3sE3IbSaBYDCX?=
 =?us-ascii?Q?s5Z5mpr471St04iAwlSzzFGoC75070rU+j5Hamfa9JJOp2A43CREIqA3mktZ?=
 =?us-ascii?Q?7Gqe+mmZxkbtuRtrNDA+4jwS297e0SR2mrJFeUIhJjAci0R6hysIvO4jyLj/?=
 =?us-ascii?Q?p5RRjDX4mRopRV1GzgCN5dyrgMqF5/o0ILaQS4HhOrqP+Ri29CrbEG2Lck0Y?=
 =?us-ascii?Q?8MaQv9gL4uYG8y+q7ail+7G8XoaJUzGzeln90tHEG6zNkAEYZgj58n16i4wQ?=
 =?us-ascii?Q?VMId/2f9vllM6h6eFOm/pM3/kmNygq4Ww+KW+L5/L7apROu4PtM3LkuyXCzj?=
 =?us-ascii?Q?7lckC5wD+kYFQ/xNqHEI9Svxg8pSq6Eev0Wun4plX755vzyK5JFb0cPPxGjt?=
 =?us-ascii?Q?13cSBdlOzvhWx0rXaQXI2jPHKrJQeFycYhzbZxSxWSPaYOnaD8j0kEBeD7jd?=
 =?us-ascii?Q?y14cnFelaXDVN2eCh2Kd99rA5Bw+rcXIZjQObc6DHwBBvTpRzZKX95UtbI2D?=
 =?us-ascii?Q?sxmvGqyyT4JPyxw86ypIQeNfXGl9ARcSuSA9NpNLipHnMmlZhiisgPObg+sV?=
 =?us-ascii?Q?9i0csokj0GW14gQgHKE9VNI/7QO1UDIwEifLAdm77OJsdjc1iqbFeCcXxHqi?=
 =?us-ascii?Q?VvZzZthrOQBzCcPND+GwgCHALjn0OWNsXigOzYf8o32NkVB5HbTJCjPww+B1?=
 =?us-ascii?Q?S8lhbdJF6Pw2zzpUrym2GVxoqkj8fi+LRjG4/HLpsnD+OumfkG1YH8ZJo3Of?=
 =?us-ascii?Q?dwopZHXIjxgP7fyTDbV+M937X9t/JHKCQ9bMXpJzsZkY/HJbtfZrweESJBBF?=
 =?us-ascii?Q?L6FR4VuJTpVcupZV4m8oDIZbcMz+oCXjk4t/XnOaJpQxeFlUr4XS+K6eezB/?=
 =?us-ascii?Q?o+kLghToYF0mEBU+b6+2nPdbC+DEk0oPn93TzUbSwjkvu3zTwKm0gFmStDSn?=
 =?us-ascii?Q?SRwj0KQsJ9Fk6/tGaDPEOTCpxdzlKGzUk34cUHItwpzon3S75PsXZ32C9WVO?=
 =?us-ascii?Q?u14Un16HZ1dfrKSS63tBxUtdBhEE9hFP3Sjwi3qsDIcDkeBWYMHM59xZztYf?=
 =?us-ascii?Q?f1y0wnw7Mf75UQAgWXfV4Gv55iNEW+p3SAWHWcvka6LPnZthFIXWUisK/zIu?=
 =?us-ascii?Q?w5aGIs7Ue+do6q6kpBj+g1UzWL+oL9endARJenGosbXJvo1tl3jbL5fhje+X?=
 =?us-ascii?Q?sWHRGx2hF0ofJ3NFtN1+wFO5SCWR4S++3HeGHInSuLxtA4Pby3LYckC5XIC7?=
 =?us-ascii?Q?4kMuSfn2UKFT3KTmVdCrZNxqfX5ORLXa2Tg/dsbpuxiBrQuee2Ki4KcufXnE?=
 =?us-ascii?Q?3Zugog0hyqXYScfhroNPkI4dNZfMFL0di7lERAMm0gtmK6qnqeGfe2GOG5E1?=
 =?us-ascii?Q?c5eM+juC9FAgvoxl7E9FzIDyTRxj98FXxfFgtMKTIm6uu3p8YSgpNk2qJW9L?=
 =?us-ascii?Q?m5inUpHM0BopNAl/dxxw97K2j+yVcxYHX/8pGRGCqXO1QEh+2Ri1OYDsnbwU?=
 =?us-ascii?Q?9BRElwZlDNSEGrkY1Zt/QZc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d9wll42ffZqAempCXFHXiicwp1eM8nRA5PufZEy1xbjKvE4X9afgMuJGYUcV?=
 =?us-ascii?Q?D2GJJ0Ru1zz9nPlXj+DrIP01PE3/kBglnCJ+/XwSsDc0W380ISfSMSA4dCLK?=
 =?us-ascii?Q?RnD2pZ4v+mu6CsKzvwiDHg/wHOzvZozfj1W8Ht+d142+os2TmY3gqDFAmWU2?=
 =?us-ascii?Q?72iIyEuRoNMJO03iWE29qw/7YhOakEzABYOKyqUjmyPIjjm+BE7awYhqnGAJ?=
 =?us-ascii?Q?VD0Kh2hD+MWYUVLaD0bBrqVXtP+sgG89gwyhglIaY8zdcdJteLzUCnRnWQ4I?=
 =?us-ascii?Q?Ekc1nM6qCR7vE3uZGEUjWmA1kk1Yv1aQPPIlIL3mL+YezQSQ5spx8T3Syae5?=
 =?us-ascii?Q?faPCYaNXcOMjFjk93oJ7Pt+v1b72m7faEA/ZBJTFNjzfXBbeqDiBinvD2eGc?=
 =?us-ascii?Q?XwXT1qjJ+yyCzWiQJ1dpIGl49qWztq1uK60+8S7E+MRpJfaKRTi9xy4cWuCP?=
 =?us-ascii?Q?Ci9izWrVyUCHC7EbQmTXRRyaUGNxGxclCpHaxfO3aq5x2yPiYWh6oO9Mf6hp?=
 =?us-ascii?Q?+7bTNFsGhiU0u/NhUQwjXqYflzYW86zpN+7EjdQp0thCx8FA+TGbJvd9nf2D?=
 =?us-ascii?Q?yVm9oc9JHtOsbuYQ7/lxEoN06ANsUTdQil/bqkrf8JqeKNuaTdfl+0Um5nhI?=
 =?us-ascii?Q?ZBQ5qbizhYkUN8PmGUxOP67RNJQfUC5HCvkliehWPe+1+i8Ic0U4jiElE2eT?=
 =?us-ascii?Q?NHLrDGMxSb0TEauHssG14nCWvxXeXWfVdKSPsX8slYGG/ePJuilga2Sz+XrS?=
 =?us-ascii?Q?tXHJ89QVsnUzaBo8S6MigWkw+XCvmA/adghbby6+6+8C/7rFI36L0jLSASSX?=
 =?us-ascii?Q?F0lBzRkPcd9MmKLIQpTa38scDPp9AOaLoK4x2L8JvBArQwgkKOpBynXfoZEe?=
 =?us-ascii?Q?sD9ZRgeWC/SfOZjOEBW44fu5EzLuymO6X2Aq/QrhCgurVkb1bt8QW4n6UkRp?=
 =?us-ascii?Q?uDpBHSvg1MZutmABOZCPWEZ3xm25hEoKDNucwf1c2Yho+vuiSoj3mQ4xe0Qg?=
 =?us-ascii?Q?mTVN3Z5QfS63BT+CUcD/20AS793ofiOoCGqPmz1yTYe4SpbhOIIPCyCjUfbv?=
 =?us-ascii?Q?OkHDUHGr01aSrpJByrDIwHLBhcL3f0+THq6nYzrRR5B5BjCNFh0jZRo66AvI?=
 =?us-ascii?Q?1j3jLu4h76zzR30YtczjYfBWF92I6q6k1ymm+Iyt7+rmY+PTBbds8DS33ZI/?=
 =?us-ascii?Q?uyxN0vadj/SynWS8T0xMAGUGwIy1onH1QqoiWE8uB5wQ7J/oD53V3/0i5aHC?=
 =?us-ascii?Q?QkAOqDMMV60bSvtHm+dLUfARjqjBv3/dNh6GsAlf8toVcntSQF5A1mTGPbzD?=
 =?us-ascii?Q?7WKYcZgKHgw0el/bind8SgYLz4SuxvJW2JEhBbXQK7V8S8aP9xMBbNpWHd5H?=
 =?us-ascii?Q?n5sKM46DBt3qJqnHgG0AROT+NPVqA38Z/CAWNw+wJFi9H2PAzUUfeDCqF+QL?=
 =?us-ascii?Q?cBJt5Zap6Q6U2n7MXrQLLYmALzFg4kHu1Mi5kTrGSRMKrAkw9iBGbu3iJmE5?=
 =?us-ascii?Q?lvD6YS8tIeCXoDTA56IxZXhDPtgY5Hr9AgnQBVvp9IK+hVnMjnEqbcvZo4q3?=
 =?us-ascii?Q?iKtnJn56YeErQfHEOz7pVvb/Y+3gBILaUqfOY//tOYT5l0dUsMRbHdDZteCU?=
 =?us-ascii?Q?Wl6SYor1Pt7ZN5mHmcl3+nQKYieBS09u2ZsLM9Z2Y1rZ2Mum8H4TuOv+hPKK?=
 =?us-ascii?Q?XPvi/CFzdS81cnWiNcwF+WY8WS9LBWs4ZOozkl4n3SfWJBQxMLuwTq6cksOy?=
 =?us-ascii?Q?uRHZg5b+eg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4688d51-72d3-48cb-151e-08de539a9fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 18:27:50.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTKSe6WnWK035g/rixE0yf68IgLgqflOv+bnlAaZVq/JW33mFoVhPwv3QMHbTBaQGaGJsx42Ga464R3UNAS9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3268



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, January 13, 2026 8:10 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Konstanti=
n
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
> On Tue, 13 Jan 2026 15:13:24 +0000 Haiyang Zhang wrote:
> > > > I get that. What is the logic for combining 4 packets into a single
> > > > completion? How does it work? Your commit message mentions
> "regression
> > > > on latency" - what is the bound on that regression?
> > >
> > > When we received CQE type CQE_RX_COALESCED_4, it's a coalesced CQE.
> And in
> > > the CQE OOB, there is an array with 4 PPI elements, with each pkt's
> length:
> > > oob->ppi[i].pkt_len.
> > >
> > > So we read the related WQE and the DMA buffers for the RX pkt
> payloads, up
> > > to 4.
> > > But, if the coalesced pkts <4, the pkt_len will be 0 after the last
> pkt,
> > > so we know when to stop reading the WQEs.
> >
> > And, the coalescing can add up to 2 microseconds into one-way latency.
>=20
> I am asking you how the _device_ (hypervisor?) decides when to coalesce
> and when to send a partial CQE (<4 packets in 4 pkt CQE). You are using
> the coalescing uAPI, so I'm trying to make sure this is the correct API.
> CQE configuration can also be done via ringparam.

When coalescing is enabled, the device waits for packets which can=20
have the CQE coalesced with previous packet(s). That coalescing process=20
is finished (and a CQE written to the appropriate CQ) when the CQE is=20
filled with 4 pkts, or time expired, or other device specific logic is=20
satisfied.

Thanks,
- Haiyang



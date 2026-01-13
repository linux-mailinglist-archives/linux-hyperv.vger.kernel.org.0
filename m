Return-Path: <linux-hyperv+bounces-8268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07649D19CED
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF0B30C6C96
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0C38BF88;
	Tue, 13 Jan 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CJzU1pr8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020075.outbound.protection.outlook.com [52.101.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A3387364;
	Tue, 13 Jan 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317210; cv=fail; b=tzhjJYzWC/LwNnDt+YBnmcg2VacYXNTWZGinWY2GDau6x9ri0aSMKWu7CdzP5a3y/NFkv9XATfTnwPzS6SnduzLDgDwWDtbGxAyMm+l3QZBWcFLaukih3MLPun+8chvUe1MGbZlIwPCKFb9YfsEOFjMkEXQ5aSc16IZSZbY+Hcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317210; c=relaxed/simple;
	bh=nI1otzaXAqnJqyC5GKBWBjPPxED8t8Jxqe2cb2/YFfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G37hjaN6mX/R+G0JXClVRagBP+I+VAeHnb2P3+PR0VAr8FE1kmozHcvbPdk937KRw8O2O7hynjmdn4/ZJslJq/BEM2RkH7p6QiAcEQoGcfK7NgxnRSHUPMWt5LQTJ5ya4xKf27gA9uRHp9LTNdTfxGB+t8pQ9yHbFmz1TCjyNFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CJzU1pr8; arc=fail smtp.client-ip=52.101.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwGamIot7uAgl260oXZxvlhpunKWJsYJzL0W/adEtarxNJb+TO05TOag2m8McYL0rOPnUShDjkQnorf/8SmI9o2RV1Xwefm44qxhSEr3L0jbFWcW+obTvMTUWZRX3RqBniswXM8mNLX61hHiqp2aMwP7bqJ7KNTIfqKEg10wVggTad56Hktm8kgN/sMQ9LPC//DFXiUGBjWCo8Scv+EcAyrmJriDDkDCzzQQOPPb6jHqJDITgG67UBawsTfOBZvtzjJ4QpoxHsDfmP1lVOiAwmkANH6cK92Q5dDW73bn1XRyo9C5sZ4Fiew8EQqQ2NqCdlOW3DtgiV5veY4nnWhf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Toliyd8cvjzTApOWYal0/AvXC4elmLCJATVfPIKysec=;
 b=PvyD5xxNEWD2inmmfmt3qPoZP4/tMzah3da+sV/fps4ItKjorDNyvJtCqedTYHKvWs+J6vkgPDUMb8a9uhc1MWZSYqgDhwZLEDw6y7C8jJ88w4vlbWrV7g+/MSUIsh4leIWd3TUPiFI5rrns5H81sEAAuXx3SyJvXaTyXkRliSJ7KnVOcI7uB5aHNLoZ6y1AEJXC0vma3iRZx5fSJUj54t+bkc+sv1N+6Yk+8vSm3Tmprgmt1ItIdOaXtPm+bzFmRMuwwbqcEUnBEvo4U4VpX24vPpmCEFBBbdp6sMvFsZuaaTuWsjE/244dp86tk6IS0aQ0H+2RM/S/DKoLXDy+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Toliyd8cvjzTApOWYal0/AvXC4elmLCJATVfPIKysec=;
 b=CJzU1pr81KCbg6fuddne/z2lnaQhLMHa6yXglnchK0UsSYHzfM1XCDnJ+22CTajbaRax+IeA6+Sb7a/i5Zohiwi85jjqbBCSZFQDrxfxPsAbB8rCl9YV77i4kKAu1wPns9+MBVTtJDOOA7nw6OK2joKRP5h3z/u7fQ2vrxAacEA=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB4325.namprd21.prod.outlook.com (2603:10b6:806:3df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Tue, 13 Jan
 2026 15:13:24 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.000; Tue, 13 Jan 2026
 15:13:24 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
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
Thread-Index: AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6A=
Date: Tue, 13 Jan 2026 15:13:24 +0000
Message-ID:
 <SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260112172146.04b4a70f@kernel.org>
 <SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
In-Reply-To:
 <SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c47e728f-c9eb-47f5-a22f-72e8344ebfe3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-13T14:51:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB4325:EE_
x-ms-office365-filtering-correlation-id: 7414d5ec-163d-417d-44e2-08de52b64bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l3ZwBf02MEaCCGekcv4c1IBVuIpUiv8M6/bve+vkYe7poztvE/KvE5Ne+kkl?=
 =?us-ascii?Q?c6CV2KaghTpncTr5WL3Jm8qg8XH1hp5QbAJ6UZRfYzAmGL2epC51y1XiJ5In?=
 =?us-ascii?Q?sRxsauhkqjUO/RvrY1TI8KVZtcjwyZoNjO4JZ21Gwidu8l7XoV0OMUjdAESK?=
 =?us-ascii?Q?uyFXdaQEsY8z5YlAs/E7kw5THViaE4tyzLD6eslPZC+QUzAJUn/CuJL0ZEbh?=
 =?us-ascii?Q?V4C3IoBpj73ztsFuUp9Yh4aEiBSfdYO6+kxiEAEkQ8V8Adkm+8O+RVC1xHc/?=
 =?us-ascii?Q?p2CnXjefPzqC6N1l6m5/9zsAD6JBNvh9l2MtIsY50BOsPPMEgR/uevNJHl+W?=
 =?us-ascii?Q?/hxpBrLJSwAvWcsFiJh0CDqNB1c4B6L0PV4Otf7nRLM7d8UUtqHxs5Auc7qX?=
 =?us-ascii?Q?erhqRZ57HEhbBAxaFdgyvaPKJj+dQqxOpn5Gj3XrdVfpsQpgRxKZEPJU9HEs?=
 =?us-ascii?Q?Zk/J9sW9V0Apzf8PXmGUhkyeh/9pUosX6Hg64RMNjpJ6gXTWttU85vrqV/Ch?=
 =?us-ascii?Q?5fJLhJjR6uvtUu17FMeVm5KKctkbi3a2Xwzqnmmecz2w+61dJbqmxUH3cm0Q?=
 =?us-ascii?Q?htoHdMR338Hz0ETjKcWT7yZWDsjp3edyKMMfs1CUAU6AihAUTRDQq9E1NJiv?=
 =?us-ascii?Q?KcLPtrUw1mZIonJRVaw73Sw2orOJsxutHEF1VF2dQ6MNUJSQMHrYQdDs0tyr?=
 =?us-ascii?Q?hSzTpiirytKpc3KLh3eeExcjTFNzMWaCHIjOt9h5pxKgzso+v6pV4OVSdK8W?=
 =?us-ascii?Q?6wZ4v2CdUgYKMBpE3LqqcciXtr1mB/6Kvakroy3l1Y1nJSfe/LqbzvdSAhpz?=
 =?us-ascii?Q?xJtRc5O3ueoj8cYDESjIPBdd6XOhWm71OXgK4EhXd//2dlvcMfR9EGm7tM9f?=
 =?us-ascii?Q?5sSWlFy6dDHVhBl2f6oKz+U9GyXTMqnrC2hEfqmlwyicoxsD5OaHVghC7WbD?=
 =?us-ascii?Q?tQX+J0G2c3+6OIfaYNp8ApN1jC3P4FoRuXJQiLpO+Sdff1T+Zat8V5/rvOMR?=
 =?us-ascii?Q?Xnfnms6TXGFSbN94d3Acr6wPxA/yWXvyArgmYZJH0lAO5wEFaoJ6qb9SyG5u?=
 =?us-ascii?Q?RcznYAHs1SvC4RSmsN6EOe12NDeIAHdlqGVlkMpD7hOfclC05HC9B3H+EzYS?=
 =?us-ascii?Q?vHIDJwQbOn+fonvL2GHbpVwloREARCS/RhQUG9VCE7XPWOZrPCTR4s9cbrAs?=
 =?us-ascii?Q?IB863vB1j7H9jQFUCWr6o86iOFU4V+0ILUw2bX18iW2Zld8IaWsiUyHYLLwc?=
 =?us-ascii?Q?R5BDCCud0BAdSkqy9XWLNpULhcmh0DtAhOr+/UdKmKcde2vKIWLNeWcGDOoU?=
 =?us-ascii?Q?k0Xqf5IXjwaqPmi4BK2EUhFvETHP+XRf9Y73X9f4EBnn6sAdtFWQWhJEVwNT?=
 =?us-ascii?Q?e/ow/EnNJ39K4T0mEOkFTXRI2YrWtjFFZ6OG85xpbM9Fbl/utk+p+5hlD1/9?=
 =?us-ascii?Q?LViibBQewNMfFCsjO0ysOQlMQIocJsAuoWEBwZ6I1cruDcTz5j7YshD9HQy+?=
 =?us-ascii?Q?pbLE0eUaOFSuaB3s2VSF4xIFIvsha1jn45B7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lw20IGx8BQPp6GcwiNEOwEyqGhx45dI4UZUhjBwWe7nBt90o+N2Sjs/l9Ig3?=
 =?us-ascii?Q?XLwgsxNw1/bSJova2B52dKlB1KqLUe3XbrLToe505bGEWjUU1ZDTK10I4KBN?=
 =?us-ascii?Q?WfFHwdkq9huR+rLnDCp3HbE8fpzvNffCjfnAXEygemVmWlLzdwc+9dGqEvbx?=
 =?us-ascii?Q?0xDxICViWnZaYXNQYm1epSjCmHfKnmKLZySoVGB78osrvvWnbC6WJr8WLqkm?=
 =?us-ascii?Q?E/3vmEG3m2z7ziLMyV5eQP6Y83LamA92ZuAttWLUzYyR0Tk928iG+Lzl0QSd?=
 =?us-ascii?Q?IYpyUAFzNVrhgx5RKFYlu6MxBWvh2nJzkVVqOtQgQax7j1dCzYqppnoxqqer?=
 =?us-ascii?Q?esFPzedqP3IhSU5NhwELc9r8cdUGjMIxNBRuGVkwDdue4+lD6/u+9+LSRQj+?=
 =?us-ascii?Q?KezVjM6JnYQlCXSUOxMvtphIebve/UaJIGOCqM55LIZWm8G0J6bTTd7aYbD0?=
 =?us-ascii?Q?0sMQZJgbOZM1EEtslftZhAPVV7nSpj0XqJMB+7g82jABi4gHr8uoQ4MEs0Uv?=
 =?us-ascii?Q?eeBVaGFraRBEoufvdWlSxYgE15Igp/L6X/Pt+H/QsrjuKj5W/dymbiZw+DZY?=
 =?us-ascii?Q?O2syUj6YX4oJ0tL5cq2XNK/ogNCi+yw8z+MlwbVmblUqVCApMvvM5opyRcOs?=
 =?us-ascii?Q?dMVQzJa3ykVVcbBFTDbN9GjcAyYxN/wbydYJzqYi7jjtRc2dF15iHpG6Y+fz?=
 =?us-ascii?Q?juoxCeWLaKAQOA2+yBqPWrfDVr1rHerX+zV0U25X+xA66Qo58nfkTNOs3OVh?=
 =?us-ascii?Q?gbYbA0Lm6g3hKg+aD1VlcUawySeVtk5p+F68cNYcTea8P74bzhiydhiId3N2?=
 =?us-ascii?Q?LVycrGJa/HMaea+6/eCQmq5/CgiuuUDo6KV1IacsBe9b+BTnNfYhGoKgWX1d?=
 =?us-ascii?Q?hBZfklZLToR7MD6wCDLSVWXUTB2xWEYW9Bh22b8tYjACP0gNjQKWwIh1/eNE?=
 =?us-ascii?Q?pZVkqYJ2HT9l6GL8hon8LR9ELL37m9c9h1t1v9QNy6C7FVSSG2f3qwsrbk73?=
 =?us-ascii?Q?bU2O8LEWT1OqNIhMHvbQAlK2kM07+C9AYIQK1sZ+UEH+gr9uvUQDiAvknKAt?=
 =?us-ascii?Q?FW61aV5M3Zu9ozVwY5tz27K/2L6tznjFpdf0jBGnSGGCbswrqXczYacROwYc?=
 =?us-ascii?Q?RQOCyp27p5vJtbY6EuDtDeXnm+J37OecwGYeKdXY1khmXAk87ZxEGnge3cA6?=
 =?us-ascii?Q?8erPo8/clGiMmoQpEhdFl4wpNerTWUlWCQvHsT7lM1n72gpxmT1UgnqPTLBY?=
 =?us-ascii?Q?y94Gb+mJ8QqAxZvp3Svjia2l3WgjZHq2tkiN3UX2sE/oPjqm6vr7d4j+ZkxM?=
 =?us-ascii?Q?nadFJeFG0maEt8E9Hjp4HDzNTutS3gIYVu1aZM03nvMYBtv/ncT1xAyiwNxI?=
 =?us-ascii?Q?vKp3M14AdOX9l5DMEmI/sXPBgShLnydmkUNwWrdfCHxDY/mfTZdGRG+TaxGo?=
 =?us-ascii?Q?gOzNBuj9ovz+T56M6QMsAYOLFDd67gnB73W0NGi3FkcxPFNj4OE/P708SNai?=
 =?us-ascii?Q?XgzJYTVr/SHzHY9sfSD7nq/T2DV6E8NRs1C2HB5Pd8v2Xx1nJ4HJN4auEB8x?=
 =?us-ascii?Q?zAkFSfEGOoVvZtB4RctTg6qZS6F5cXiGNTxERHfUdZvIrvYokP65fZh+pEMr?=
 =?us-ascii?Q?+8DkxVBvHDbEXI1AJYg5jOguSeitAJ6gxFFBxaIT+GwL72BWGgNUGt6qoXK0?=
 =?us-ascii?Q?kSjxhcO+XKrwyvG6B5GBUliD+DbYYKaLNbo2Uf7lfjMmyDBJpWykrb25RQrL?=
 =?us-ascii?Q?n3N5+Qoo/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7414d5ec-163d-417d-44e2-08de52b64bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 15:13:24.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AGAAA+wfvWjVqP3TwHUf79xkmHeJGXEg2ZvGiudzZyb8upV+hJ3/lCc9UWvdnosJ8hbsmpQJp/6qIiCn3DUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4325



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Tuesday, January 13, 2026 10:09 AM
> To: Jakub Kicinski <kuba@kernel.org>
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
> Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Monday, January 12, 2026 8:22 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> > hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>;
> Konstantin
> > Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Ern=
i
> > Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> > <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> > <ssengar@linux.microsoft.com>; Aditya Garg
> > <gargaditya@linux.microsoft.com>; Dipayaan Roy
> > <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> > <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> > Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> > support for coalesced RX packets on CQE
> >
> > On Mon, 12 Jan 2026 21:01:59 +0000 Haiyang Zhang wrote:
> > > > > Our NIC can have up to 4 RX packets on 1 CQE. To support this
> > feature,
> > > > > check and process the type CQE_RX_COALESCED_4. The default settin=
g
> > is
> > > > > disabled, to avoid possible regression on latency.
> > > > >
> > > > > And add ethtool handler to switch this feature. To turn it on,
> run:
> > > > >   ethtool -C <nic> rx-frames 4
> > > > > To turn it off:
> > > > >   ethtool -C <nic> rx-frames 1
> > > >
> > > > Exposing just rx frame count, and only two values is quite unusual.
> > > > Please explain in more detail the coalescing logic of the device.
> > > Our NIC device only supports coalescing on RX. And when it's disabled
> > each
> > > RX CQE indicates 1 RX packet; when enabled each RX CQE indicates up t=
o
> 4
> > packets.
> >
> > I get that. What is the logic for combining 4 packets into a single
> > completion? How does it work? Your commit message mentions "regression
> > on latency" - what is the bound on that regression?
>=20
> When we received CQE type CQE_RX_COALESCED_4, it's a coalesced CQE. And i=
n
> the CQE
> OOB, there is an array with 4 PPI elements, with each pkt's length:
> oob->ppi[i].pkt_len.
>=20
> So we read the related WQE and the DMA buffers for the RX pkt payloads, u=
p
> to 4.
> But, if the coalesced pkts <4, the pkt_len will be 0 after the last pkt,
> so we
> know when to stop reading the WQEs.

And, the coalescing can add up to 2 microseconds into one-way latency.

Thanks,
- Haiyang



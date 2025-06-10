Return-Path: <linux-hyperv+bounces-5836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B49AD46F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4056A17608E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1D2868AC;
	Tue, 10 Jun 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KVKZ235r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022099.outbound.protection.outlook.com [40.93.200.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3723816B;
	Tue, 10 Jun 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599040; cv=fail; b=MQkJC99QjHkYIthE/ypQAPtOk9dhaT7d8Qr1m8eIeTLt2HQNvU2WYJFCLUND0IbToTGUN1YViV/RsUkbcSFxSlJBV7LCcvTfKwtYafhmwK2kQ0cRYK/tvSRP6m5QJ7X3hJgqoNHWDkSFcWrS5Y0PTVCcppy2pcbB5b/917i7Y3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599040; c=relaxed/simple;
	bh=m9sj1vIEbpKnAx0Jm+wepPZdFaiH1HepiFS/at4neeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HIuWKm1K9KJ0bVgRU/qXF7lR8377sdHSqOc5DIY1TAFk5cmn3t9dj2qTVQc7cZiUX9PXgoaAaU498sY5DgG4aSMpPIM4cQyyK7JEJEN3Koqmov54LB1CyaydHOFzX/r7PY7H0suhfwIDy3Gjvk7pZMpETzdU7FVhsqlqvcdhevI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KVKZ235r; arc=fail smtp.client-ip=40.93.200.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGAnjnOmhfwFCQ+QdS9NypxgShpyIbyOh0q63SOpZQthHBARDDthb+vhfIPIZVuIMoyn0kr3rqEN8h1NcBYxQVcKM/w4UtGUVNArSL7A9acj5JH9iDHRHfcjDU0YWgEyxFW8ExuvcOR9qDXVX+yFsYwqxiVVet6UCfNa8n6gem7QHUnC8sMtPbQ5QamOKOcnL9Rb/hKfyopHRPSP9tmNOrD5BEYFWrJe7qWRmO6J+txzNZ9rVNTtdPbcH70B5ZUajmA3nr/JAEuzg0MoLTeRE+ZO1flbWv9cPt2mKdHP2jK0OX/0pi4pWA042dHYTtLmyGI5owsGgxIVSOhFtjCM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSFBhbezsjuxA0XxRq18Yr/IQD3Q0j9OU01P+eEgArY=;
 b=upH9jcEkqTpEnmi6TvffdsV7XNN30pnG98wNHK8T1tQfuHeIt1epDpSVntBpkcFNkChsADwDpgW0JOTUu027rEme3Y59pQHCry8Z+Z6dFARLDmMBQvP5S76tL13PnBvDaHnuLwvmFLSMKghrJS5pnpEaq8RHDZi+Bjd0C5GWLT5pMMPJY4Z/zbwWGRh3dsn8keoi+CG7s7Yy3qCS9E5MVDDPFvuNdQAsfdHTTmZBq+cT73Tc4vBoN4CwxECBbKet2gAy5jKJfWkfJEdDeq1O3AXKYSjunjHEZQGiV6qbBwojvrurDjzJrijIjcyrk6HOoFBut4KbBKG5I8txw+xALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSFBhbezsjuxA0XxRq18Yr/IQD3Q0j9OU01P+eEgArY=;
 b=KVKZ235rlUFzNI3obAVTJOyaTAzBALrlTpxnTE51ej94OI6pTXYksA0OUHuTiYf4dUMXCWnvrBCnUlMy3wp/8odgcPmOpnW/A2hLnid8O3u2FKsyFeRlXjt/DuuiwlOF4t5c620GGYp23LaDwJHX0fKzKDayZuEcuqtGhHOBqso=
Received: from LV2PR21MB3300.namprd21.prod.outlook.com (2603:10b6:408:172::18)
 by LV2PR21MB3133.namprd21.prod.outlook.com (2603:10b6:408:179::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 23:43:55 +0000
Received: from LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380]) by LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380%3]) with mapi id 15.20.8835.006; Tue, 10 Jun 2025
 23:43:55 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Record doorbell
 physical address in PF mode
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Record doorbell
 physical address in PF mode
Thread-Index: AQHb2lgDxpgXIzbo+UqB627zHP2mRLP9DjMA
Date: Tue, 10 Jun 2025 23:43:55 +0000
Message-ID:
 <LV2PR21MB33004495584CAB875065C4D2CE6AA@LV2PR21MB3300.namprd21.prod.outlook.com>
References: <1749510580-21011-1-git-send-email-longli@linuxonhyperv.com>
 <20250610153534.0011c952@kernel.org>
In-Reply-To: <20250610153534.0011c952@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3e4514ec-eca8-45d6-bd92-b7dcc794e286;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-10T23:43:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3300:EE_|LV2PR21MB3133:EE_
x-ms-office365-filtering-correlation-id: da803d62-be01-4e1e-0c17-08dda878a9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J5TUdY5unYEQFLX+68RVJ8aj5wRG1iZ4lR66oNd/lCEDlzVjMJG8KyKfy5zk?=
 =?us-ascii?Q?g2vnqSDMSIH1JnbB5T8vn5oc02EeRNs+Ls/tiLivVNIl/SeWChukLGPMQiA1?=
 =?us-ascii?Q?GjMIyUsGDWsEL1Cqcsu/uWHyAwk7WNv2s0WyLoUK8uqTTMtoM7cKr9AyLNeM?=
 =?us-ascii?Q?LMIayyWtEtePPW2uGEG0InS6hVr4IXx9ne0eo5kmnsO0fyVhV0rZ5o1IqLKO?=
 =?us-ascii?Q?uG2V1lOAeyxPZQOT2GLPHdGtnMmRmm7jeywK1tLH2bE1EJLym3Edp+gddGuX?=
 =?us-ascii?Q?fI4c4AnlUZeZtXc9ReAn+Lpw2lmGybElZ3w2dLCa229FosKwOc6LmkJwrWp/?=
 =?us-ascii?Q?HLom4IDxxgpRU1FEqjtMJxTwmzZ0hxKbik1eKN1hM25Fm44P33LK3KyE5ijP?=
 =?us-ascii?Q?s+2O8x8zZ8rQvr9PWKvIFSXvm/gvVqnyViHmzHF5HfiThjwFHR2C/nr5gxg7?=
 =?us-ascii?Q?NHsela/6fa75tCcwepFzdq4vOBM6roPqey/693QPQSwJEPffuzH4JNrm3MnY?=
 =?us-ascii?Q?97gmfrbO7QUkZvCg8puknmOLFV5yH7DAYvW5IqWbU8xZTikToRVPe7X+lCnJ?=
 =?us-ascii?Q?mZyXHjIeNgPJs24/6+70TU+dyyMXab7oD9mqlA4ehvFyf06wFjaV/8c1cMEj?=
 =?us-ascii?Q?N1sOz5P9m5P7TrkeiRNXI9dL3/LXrbQvP5c++wJTpvnKjFDZkBqpgE2r0MK3?=
 =?us-ascii?Q?IezRteVa/9HAa0BaJTEzUE3+rW7uhHUTILI4jjP8ByufbZTn8whqnuLpn4Ao?=
 =?us-ascii?Q?mzeW7nKRfzudPqUTLjoWopt19s+6TO/xkZUkQk2S8wfk5usQCI0yHx7s6jr1?=
 =?us-ascii?Q?K3gMcbTdltX4JGwnS3L2qHHWi7uoskqzkPZSL0CXAxX43HfhLJmNW6UDX1Vp?=
 =?us-ascii?Q?Mo8NhaRDek00jp1u/pWtteOm0Hykr/h9Hc+8Fr6xJw3YnN1REfxoCPgB7rjW?=
 =?us-ascii?Q?oTf1SmgOoFcB3A0CCh8IrU3G4fO+1M3X2Cl9vzPK8WxGyb2LnYScFGPcODVF?=
 =?us-ascii?Q?06JaWoU3PShiE6zbHOUudPAD7Y5go7+7M2eWkBA/OCutFTaYvl/rzPNaTlAA?=
 =?us-ascii?Q?yW7K/zgv9BcjlPWt8HRtZFFribjfeUDItP0Vl6pGqfaTuV1JoFkNaTZbn6Ex?=
 =?us-ascii?Q?qH1yk76J9f9nsaUzggm4+tYHNKae4+NFGfZYgQJ9HguK2bz7w12DeFDbufen?=
 =?us-ascii?Q?LtxDfJSq0hku7gQOFJC0rMqyIwp9EW7O30jxtESVBgJ5eF5GJFKc41n+MFd8?=
 =?us-ascii?Q?VS1OD7qBYTuHzKGKSOIVc2flvZAsIk/s3LqTFugYAi5v5DB6jJC1wyuiOrlP?=
 =?us-ascii?Q?OO39rz8Xz9ATO+aNJrcZp9wTzyiwliSWqXxL6IGtTP35Caj2cyCnW0jVjSNJ?=
 =?us-ascii?Q?ODs8YGyqX7oluSp1Ks30YxX/dGltWK1HCQZPwxGZV0SFduJie+k4lwvGhqZS?=
 =?us-ascii?Q?7SiWRn3T9N09oN29E6pQX3tbPTqU43+3by/rKwRZT0/NvsYZpHjZ/w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3300.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4y+jaqLaXAqtBRxYk+Hwewr4gVORnCGm3BdsEJPoYwnePPKZry5l42va3k8z?=
 =?us-ascii?Q?9vIGik+ItyAcVpmGdBaXh2pd4Rydq3YH9D79buN8ywh5zsTcH3gjoirqgJZt?=
 =?us-ascii?Q?M9w7Z2WJkF2rQauMd3sUtIKt4YuNYfI4KpfCzy4tQ2eT8tsIofNN6tt0NQuY?=
 =?us-ascii?Q?eDJGiI82iSnf8Q7QW9uPyU2o7v+XWocNF6S34CmiyxYXPbDVtylhweIlzc3y?=
 =?us-ascii?Q?CqAeEGNxxZwphrt7FwOF1m/ObtmddwYMUfa4zYrXZpS1aA1G0swhrx3tEK5Z?=
 =?us-ascii?Q?9G8lSDp5kjiyFfDAZgEN0frH3e10VduVeAsJfUrIwwdIFNBudGAM0sRHt8yo?=
 =?us-ascii?Q?mIQ2C92s709+Es8oLklfwxaEQcCy/TQYMtHahGDVzP/tO7Qno6Sc5v8ycXPU?=
 =?us-ascii?Q?CFmOuchhm0UDsPC6J7sF6FvcH4eswgFFXErPAOpuOW7OU6mZI27VgH/k/6X4?=
 =?us-ascii?Q?C82UBgWBBxr4xv/KfaS70w2nIfHcBiCljgA5DQms4oigRP50wLbRhZXjVcgl?=
 =?us-ascii?Q?i3bJ0ZJMibIrkoAlQKvHV3iM7kVQ7UzKT8/b/3ycJvWflrlRIdnUDXPjwhpb?=
 =?us-ascii?Q?kk4RZ05sA5jxKIHSXqkl3xUTu1CHJYPNYF+u/YwfjLeXfGsiodBmzWnv36UP?=
 =?us-ascii?Q?gbMO2TW5PEtcWEtcxGu2+6S0MalN7W6qf8/9PTx7QELczHEMo3KD4bg0Xhor?=
 =?us-ascii?Q?I2dfyMtrrqVrgi5ERcnQtIv1Ry7kV95AvvRZ+eydk7YckKBkV8xUygvjn1sb?=
 =?us-ascii?Q?xVR4mhkcbyGUqJuEgT8w8BazPV8wKkZvruq3xALNhjv9I7tTRal+VUIc2PM+?=
 =?us-ascii?Q?1w4B63xmdej7UJ3rjVmz0LFmUMTkftqPyVcKsNsawtAVWcmhPt2aXcDt1mVP?=
 =?us-ascii?Q?/rNcLj9wyVcKE2FHVjBK/lAu2T+3J754AHfLsIPL38JHr15FVW4NeU4U3L+I?=
 =?us-ascii?Q?zbWCm99lr8qupw7Cx0mtQk/gf0oXn3tGWvSPo/5JODsDMzP0066yi5Nf9Qj1?=
 =?us-ascii?Q?/ARikBZgPQ/VppDp6wegykB/N/S+Gfl3/2zU+qM7f23yF0kIcaS0EOfR4Le3?=
 =?us-ascii?Q?pUl372Dfnzx1u9ztUgQBGpoTMgxgAQaldQBdIE/zdkhYwpEL1u4+H2u571Nm?=
 =?us-ascii?Q?HXuUtb2hLnB2sHg4mL02mueLOhgffs/vOJeyVXg9gJBuA8VUr0l/0tojI4mR?=
 =?us-ascii?Q?tl1XVJ90gzd4vCTbigP0ZBt0rsTKkRGKPlzPzVHj/3A7dLtcwmyXsqtbdzej?=
 =?us-ascii?Q?rOHg8syTQJ4RDRaIj07tjgAtjkZVz/2YZgR1nJuOCVGcK69DSs6z5c/hOMt3?=
 =?us-ascii?Q?rSovcGyVGoRL87mYciACQ/yZq5Fx1/yd63vU3BPCEaLU6sJqYNgxLTq5Klry?=
 =?us-ascii?Q?4PiVGHYBweAIwfVFg96gjr1YA9L5dxmylxNQ+359446K6oHdI37b5all1LAR?=
 =?us-ascii?Q?OXUCVYlV5XersxuRw80J5WECCR0Jn86Bc7IczwDSDVrF7tfyolHUHblKEYHL?=
 =?us-ascii?Q?Ke+5f9nMuHUqhr7Xehi11fiXtN25/RPKA1F8k8WkKTYBjrNUB1zENc5VFfLu?=
 =?us-ascii?Q?+eeYaHZSQXYagbaBUDrQzG5M2qHRduCXu/gWwcRo?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3300.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da803d62-be01-4e1e-0c17-08dda878a9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 23:43:55.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0krxs5sqLCxXrNjXCvF5ypOoVvjmPziDb15HVSszCLAJoByBU1VqvPB3QKMwutYYCj0ckQhPzZorMDeYxVO98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3133

> Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Record doorbell physi=
cal
> address in PF mode
>=20
> On Mon,  9 Jun 2025 16:09:40 -0700 longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > MANA supports RDMA in PF mode. The driver should record the doorbell
> > physical address when in PF mode.
>=20
> Could you explain in more detail what happens if it doesn't?
> What user-visible improvement does this patch bring?

Yes, I'm sending v2 with more details in the commit message.

> --
> pw-bot: cr



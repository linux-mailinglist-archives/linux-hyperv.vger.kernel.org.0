Return-Path: <linux-hyperv+bounces-8493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEmJFlrYc2lNzAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8493-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 21:21:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3DD7A8FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 21:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19503007C85
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83C2D63FC;
	Fri, 23 Jan 2026 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NPtqqrtb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022132.outbound.protection.outlook.com [52.101.53.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72684239E8D;
	Fri, 23 Jan 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199687; cv=fail; b=DDZ5UU4K8Dh2wARVVwMkX/K7YsjXpWZ4HDxLg+AIbFq/WW3PUfndQu1Nc+h6mgGjGEXWRNOgtmQdAtILn3QHzP4RnnaFtsSIz7dSkQyuFZDo//W2tmZQ8pQY5Q5LY217FkxVxFP2ttpfX8vCaxt4mEbvV6WjDwPVGxAS5J19Ah8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199687; c=relaxed/simple;
	bh=8uQKf0PZQSttOsEeGF/rYszRZO1oDmvbc/1KwSX7VwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WuHBI3Sat83vivg/MB9hvr0pytSpTvho4kezobnKq00vIL8osDLuqjYFqDHC2wnov0Jp5/x54kNWrsasjbhGg2jESvH+lpnA1RyJF6sSQXCuCCp/gVxGACJ9sxlglKfgNh0GZucd/NHk8nwXUZJqYjv53Ee3Dy+2ekgf+gqyEpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NPtqqrtb; arc=fail smtp.client-ip=52.101.53.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5xLgUkQsi7svnVy6m3F+StcrDGF+adgs0A1GU95IMnilXF1Tn1AGwp/4FjVKgJ7Q3l86B5ZDcg1IO+ytV2iuhaC4yHWNuN7ULI1acjLXSyZnWikY+0Z/4Hf2CnV/DDrQgJqIrgP71D3CFKVK6oJWJri2YEXuJPl17PfUGjPrc4LUzYB8QSfIlXkC6v6dMGZwwOBpbrxYnCbbWYNIugbZZLxAITzLjAke7XsNk595WrL7G7VnyTay3vnLiJh2qmqCDtpQhrjH8/t9clJFIU+OlV99BqK8ORPOX1gGtObWFhYR4mWK5eLwikLvVuUbr19BeyxzJosAQ95xRq+rempkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uQKf0PZQSttOsEeGF/rYszRZO1oDmvbc/1KwSX7VwY=;
 b=bHeZOuK8MiONgArAK1jdGahmbq/5DxiBdO1/b/8WLgIdsSVCOJvfP3mKTlxY/nY4nMSk8idLEp46pxs2uJtO9eYCXSxrWElviV++Zd9B4zgYUVXetV/FHlobRIrlteVsUFnbtIIPqpRjfMJk3hmNh7bN/8W92cu5U2no74UTsppn3+jtq9r6mj1XR6o3nBnNA2f4vd6+Zba3AATjNLpfQ0Sd65TniZXZL0/Ky46n/Cau4wbS0yd1jnfdn2H31MBw1M1Xx9NJ1rHFTDk5NZVb0lZrmIkfQEHL7N9xcuwN6Q1VetJK0T0K7kUPi7nHN3grEg/+dCEGQqyQppzZBGv21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uQKf0PZQSttOsEeGF/rYszRZO1oDmvbc/1KwSX7VwY=;
 b=NPtqqrtb1JlCWnmjgoKH1ms34apfaNTD05u3Cte0JaNEdIli7BNyMR0WDsEW+aEidD5HWu8M9ZyYrJt53gHPlsFbyW/Hdy93kQwryYaMQpL0h5zaxw/K4HbrVkHjj0QW4yOI9MjUxekLyPEcuARqtiD6dky1BIokmPzCz366Kpw=
Received: from EA3PR21MB5891.namprd21.prod.outlook.com (2603:10b6:303:2b5::6)
 by DS4PR21MB6891.namprd21.prod.outlook.com (2603:10b6:8:2e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Fri, 23 Jan
 2026 20:21:22 +0000
Received: from EA3PR21MB5891.namprd21.prod.outlook.com
 ([fe80::eb2:c781:bd78:235d]) by EA3PR21MB5891.namprd21.prod.outlook.com
 ([fe80::eb2:c781:bd78:235d%7]) with mapi id 15.20.9564.001; Fri, 23 Jan 2026
 20:21:20 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Matthew Ruffell
	<matthew.ruffell@canonical.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAAMhuoIAAIkNg
Date: Fri, 23 Jan 2026 20:21:20 +0000
Message-ID:
 <EA3PR21MB5891CC7A705C6F07EC9389E7BF94A@EA3PR21MB5891.namprd21.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=338abb11-d985-4d93-9f3c-10f1c72694c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-23T20:19:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA3PR21MB5891:EE_|DS4PR21MB6891:EE_
x-ms-office365-filtering-correlation-id: f0723ffe-9160-401e-e8d8-08de5abcf8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3v5dA5Pkm9dkf+J1N4diS/9spbPaipFhjJ6cQDN0qF8zP47eLkPol9SHorGb?=
 =?us-ascii?Q?1V9NXaTCDcAAtQ3MMOrZgMCA95S0/cvb32/xSfUZQvARBKCfa2sWs0vee/UF?=
 =?us-ascii?Q?DIgoAokhOoumpydnm/TyFIdzCJe43CIegr+8l+dGpIyngp0ZHkKfDKIUPVJw?=
 =?us-ascii?Q?RncxCO8EjKmzByOosBx+jn8mI9sVFMzwlp3wH/7rvShPcOFAxyIO2ZS17SNl?=
 =?us-ascii?Q?1H1BNKEPFVioDTDDYcgACEUyh+UIC12A3JasuPNxwmxy+W5QZUmOLjyJLVNY?=
 =?us-ascii?Q?4Gn8JWxmk8cA2vEcm6XuNJQIZgToHv9e20FpDtETYMBsmeug5YCMEVqwGruA?=
 =?us-ascii?Q?THEgHBYR53QWhbkqMqULt+EsvZbtbuaAKiaxiLb6u4Bjey8Ar7Vx+QJPqeB3?=
 =?us-ascii?Q?5uz9+lisU5KefOU2pj54b3rCI6KihbiGQ+d9LY6gJM73kkdfbMRh2KcMrigO?=
 =?us-ascii?Q?HUjf+nADtObxm6y74MhMUGcGUUf+/iD4PQ4/UDCE5XwqMSkOILcnccXzDoEL?=
 =?us-ascii?Q?KcC+/FsiHFMnb0Crnfp7i1Ooyy2WYq14WXPosCbh/ane2IJfisw7SS+sygUR?=
 =?us-ascii?Q?r85x10Vep/x2Hy62JcrGsKE19Vvje3LftVM3hWaSQYYlEF3Xck64U6l/xdmo?=
 =?us-ascii?Q?8Oziby3Ws2iFZpQ88SBL9QyXGkxtmI1OpHZdYBR4uadFjvWhIu52XrfvIcGn?=
 =?us-ascii?Q?saCCh1+w06YJhJyx3KUOxysFb3hm0Tgw6ccF8jYpoAMWaeFc30kcF7e4wsmn?=
 =?us-ascii?Q?7B/9Fb1guFOEchoHxzQ/Nh4KEQNbvTptkENzEj+Aa0zRMuo45HaTU3MPXeMK?=
 =?us-ascii?Q?qeTa2QCKOXzUmfTf58XAtL5V7UTJEspQl7oHMRdkvJ6cbXlzZ+dbvWqSm0MQ?=
 =?us-ascii?Q?Z9XXq8bZsxA6NwtvVgbXLF/csecAdeGUE8pfyU41l4pwUJViHjg6zMVrzYL4?=
 =?us-ascii?Q?E7RuXnurifbQWnD5PEXMoUOHv+3WgJ0AGxhTTJSwEuCsDpl/Wov9vU9WrBeU?=
 =?us-ascii?Q?z5dCoAwszohBV7MMoaFnAZA+ROOzy4ztyVkUPpl3ILOlDKXj4PJpHGj+ZFyh?=
 =?us-ascii?Q?axM6SJ2CWkMI79AdWLCgRkQ+6e2jYfQ29xBz1gV7+SAhBCHKhDPrwxGDadGh?=
 =?us-ascii?Q?mrfNdw8IVTElOXLaBbOH5CM99C4UQLD6bQZp35LubZ3cSbKuV2Kp8mmJfbIC?=
 =?us-ascii?Q?8XOfQa9OcRs17Q+RYB8SQj1pJ924IOcgWPgW58jMozoh1or+ZfUDI25qQMxo?=
 =?us-ascii?Q?pe7/GMd8e6cmzjZqYBM7va2Ds/SaZhHkQ+gpYbmeWaUHxaS1Y13ULXWBZpPi?=
 =?us-ascii?Q?FEdmqQMO8berlM4cYcdU3YCV7yYevUrZ0LB9CNv1kl+cuckZmKK+rGZWSa+w?=
 =?us-ascii?Q?8ZW5uNgy02xuH2UG8zJ1gsAdwT2Ibi8nSj3CbtiB6RV5V6NDsfKbxAReU7kZ?=
 =?us-ascii?Q?UjIlBIzHr0HW9CNW86eAjWVCei8f1VeP8JQFj3kumauBH+kNAw1lqYbKyxNK?=
 =?us-ascii?Q?Iqp6K+PLa79a70YKA/ZPeMWK4J6BWlpNWKMgQGIAOO5O6I8t4a9RQN3G9G+v?=
 =?us-ascii?Q?5YopXsRv81EvdVEsjlFFmPu8b1DEiKMh9pnnN5hq42RTS1WcHjoqaAS8wr8l?=
 =?us-ascii?Q?NGdtjHctN5czBPP2Pq6QFWk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EA3PR21MB5891.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cw/PV1vuuaaRxJOue/fIHGPki/Er57RXeR87n8TYqXj+Hc2eKrKggBlcamoU?=
 =?us-ascii?Q?6S0tk06ee1n+c9BOcd/nHnqxsmuawNt74s6g8LLk99vR5vN0oH3XMpa+nBXq?=
 =?us-ascii?Q?xFUlfVrHm5RyA9xR9kSWb5ehWjG6c1WW/XV2nvMh1HLWMH3uzsmyndPRggVw?=
 =?us-ascii?Q?Oo+w+686LPacQWQmETVTiz5xoOwXH3peqVrEn9CYtObhrqGaL1DNaC0hxZ72?=
 =?us-ascii?Q?I3smNA8VAsa04rtbn5fSGTIanFmOIXgDCvVYkY5aErR0RsixJ/AexyyEZoUD?=
 =?us-ascii?Q?Sgw2yufdHp04AbBR5vR+Y2/Evy1N6QJ5Ff6YXdlaLHLM+WE7QO8lx9dzNGQ7?=
 =?us-ascii?Q?iPoEizqrBmeaou4ZzhwRCYli/ZCQgDNr66ZBj4NOsegb7t6OxhBrgFn0+SNs?=
 =?us-ascii?Q?PvFIr7N2kFUhENK4DBpXb0DFko55bOSFYZ/8VLM5BqN5zGfTxNLlZlRrqzBB?=
 =?us-ascii?Q?y9njPHpKodG0sTrix9OIL8Prbsn+h2jZ5g5IVi7XRNdVoL9+kwZZ2XPx/Dg1?=
 =?us-ascii?Q?bW99GfGIBNY0SChex3IZnNDelLitIIejgGCynCdYlnlTEw3Qu/TFbteuxlnN?=
 =?us-ascii?Q?GgCrDs5VBwoDV9NrvjDIzBRCWYe8e7CJilPjRC56EdqeDwYvo7MahijqDS9s?=
 =?us-ascii?Q?rlqXjItQyP4DqVN4PLjL3Qe2FInownXvi7+jRSeRTDV0I6wDnFsr9//ILe/X?=
 =?us-ascii?Q?b95OkRTnF4J2WLNosFioee/eoGMc7O72IPSjAeNNL6mtHZm69F201wL7sOBk?=
 =?us-ascii?Q?d9J6T/zCa9KrOJrZjRyCqO71O0FCPscte+vnK/wmuoe7+3+JbjD+x8UCFN5D?=
 =?us-ascii?Q?lBFtwUw/HwfofJ38VFvWno4jotWHQKQb7pA4PddOlS7zhqHwu3jLejG3PZU4?=
 =?us-ascii?Q?bedSbhUCwMIwjfwZjCOk0d9wlNqw17Mf9NwA6uqWnanWYlw6tcSadbEONJsU?=
 =?us-ascii?Q?MKfCdFVQL46jyv0Xt7wIISnRvOCLxSemrXlsaNpseNkXvoxDu39139SsG4RS?=
 =?us-ascii?Q?BK53RS/YcueKqORU1fYuZ+6WNrIBrPcnvRt9/TtYsg8He9L6uKEDRUf+psyt?=
 =?us-ascii?Q?ZNRbqK9rfuiyod9rWAnew9AhIfgDdsqHD9h0716xaBniY8LPp8rwh6mEgveK?=
 =?us-ascii?Q?wxkrT62C4/efbqIkymwvGESO+xh1JD4clYhob3u0Ys1LixUZa1L1UEfiJM+p?=
 =?us-ascii?Q?C1uzHPpF46mbh+c4hyAJxRK+48X7pc4TtdTC0KyyItpW/fEj7M9+VIpo+MRu?=
 =?us-ascii?Q?ESjGphMHwN9wP2S8FLHxdIYxDgh7Nv0f5e9EoMhiSayLzbnKxB9AJFaGtWy9?=
 =?us-ascii?Q?fhu8WL7tR6W52ELsIc44x1Pjm87WWQAM+qUNLNxcgIiVOZ8EXSZKECjmT6tO?=
 =?us-ascii?Q?HfdmqOh6wgPV8rAKXY9Ea/g3e8VG5LD8rgs4DoVVhbaK8U1xh3pLJ45CkeOO?=
 =?us-ascii?Q?9rzRNH7+lQIt4m2VD6KIycsU/r8xRlxi6yaSkJREW4vx85uIuMl+rSKJL7AI?=
 =?us-ascii?Q?rP1WzdaZzBiwgQ7/kdhiSEGcm1xk9mcFD3h+yot17jAJLQhAGbNkUawGac15?=
 =?us-ascii?Q?aZrWCtlyZbawh7qI9NTP/ew9cds8AW5ulaCmghTQFXFSAlwQeyPAfSiyfY6X?=
 =?us-ascii?Q?HOSETPHeO/WcFsvBBtCN/42QbGyLa18TzkUbsgp+PH0znY+1tpW2MsZWVOmu?=
 =?us-ascii?Q?K+MsWcsCMVSdIQvykixsvNghVuRpK9njsrzx/tjTvzrxZR13?=
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
X-MS-Exchange-CrossTenant-AuthSource: EA3PR21MB5891.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0723ffe-9160-401e-e8d8-08de5abcf8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 20:21:20.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pWlON13aGaSU0eznZ8OO6GUddgaqDTIMbbvrzRWXIkevw0gfo7wOOgRgUXwO3xWjtALC2CVWxfrtu0gALGqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6891
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8493-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,canonical.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CC3DD7A8FE
X-Rspamd-Action: no action

Thank you for all the good input! I'll do more research and report back.


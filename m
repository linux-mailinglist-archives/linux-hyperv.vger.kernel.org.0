Return-Path: <linux-hyperv+bounces-2487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C7914734
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7961A1C220A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286E4965F;
	Mon, 24 Jun 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MaSfX2QQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD13C17;
	Mon, 24 Jun 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224299; cv=fail; b=B2DM2dKYOvDkC8Qj7YK9jqEO+tErHH48KIMGNedLFrns5C3ciuInfAdmIPvEwBJL24TeOUlsKqpS+Rg9VLkpZT1GPvm0ax6ivJTgbahmokW2WyxU1/YTsZ8hoUNUfvfgNB/vlPA1VUcwqsoxlyJDy+G9YNGwvrzzH2zzaAPSRGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224299; c=relaxed/simple;
	bh=KOotCQYnneba39dcyB4hwgwwv82yFyT63Vo6tI0q14U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0uQN2WG7XZMe4UrCHVi3ILSuMAh+a20Nf4spsJ+E7i5cnUdCunXzIdwOqzXGfQspwV9T5dkKepYkhu8kVqBOTs5brKNe/8O+zw72mtoq0Y7YJoq4LexWxXukGzDnt0TNzdRf4+HKsbVOEDlX/AzozS2kN2+HUIN4HlidA7NDeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MaSfX2QQ; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2KxRwQilJynvRGwAH5plLQhCwQ8GHTMe4hbE1Sc17wehC2QpHiXSsIYQZkPacLD4dVNPV10ZdhfdIZDcX9264yI6YpPitfBuyOcQ0Qc6r7vuUCImUCWDzjujqTGpMxxcbUnZtT/5DrwhxbWB46iC43UoG8kbPF0yswjPArxmtLaqVqBoX+5+4+1Nf/HJa8EyARDG5UNBkBe+601reUJAYHgtAXqYZTmCV5sNpf7SoWtfeCVgyFmjShp7XhEb2ry/TNBkWzqDzG4E/6CUNIjusOU12g7E73rPLR5NIfQLzVB0ZSDMLictZvMyaSn0Th987AKsWoAmRsilQNjnf8dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOotCQYnneba39dcyB4hwgwwv82yFyT63Vo6tI0q14U=;
 b=OAxQUh+H4Tjwev9NG7lK0Gxtdzv/2ozWe1qbecaPHlrPFXVb/u3vj0J4sFlwi0tgz2y9s6NzD4E8G60KWgVvhvK0NLgnO/Tn+1PMlpQb/ruBrwC4PRgz1J4J7gZsCVks2/vocB4UyMjKEcH4SW9dYSliJrnGxK1+ho97d/6+knvjjj8hgEEVhhg1M1Epzv8xLQSRonC5LGpzT7BMYVajBcr9PH9+XO8yLGQAsNOizVrxHREMpqTLvm9XqlEe0W5pHuu2WEDSkT3YMG+pAnXrAlIaYM2HMJsRMtZesOBUaL1bvafpgeRO5FHK8m6+qf7rzSag34UiL3tc0XsVwSvDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOotCQYnneba39dcyB4hwgwwv82yFyT63Vo6tI0q14U=;
 b=MaSfX2QQ5KhmOkVd0Kp7dw8Lp9RtncpImnU1AI0W0dFcxybhCjAKYFjpBXJxyxSzPArmGIwlQKE7YLnAThKf6ToJtxr0dOFpggTt2DAw9KqpTegkTrgtAbYXG2n6xFbCFU5pRFvIRBxqrLNUBy07K7yVsQgzmpT9EW60dhRtoYk=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI2PR83MB0743.EURPRD83.prod.outlook.com (2603:10a6:800:27d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.6; Mon, 24 Jun
 2024 10:18:13 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Mon, 24 Jun 2024
 10:18:13 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>, Ma Ke <make24@iscas.ac.cn>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Fix possible double free in error handling
 path
Thread-Topic: [PATCH] net: mana: Fix possible double free in error handling
 path
Thread-Index: AQHaxhHwe3XQA2mrwESzklSZLrHzbbHWsx5A
Date: Mon, 24 Jun 2024 10:18:13 +0000
Message-ID:
 <PAXPR83MB055933D7638738717A5771D4B4D42@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <20240624032112.2286526-1-make24@iscas.ac.cn>
 <BY3PR18MB47074E845C5C5CD540C8552DA0D42@BY3PR18MB4707.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB47074E845C5C5CD540C8552DA0D42@BY3PR18MB4707.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5f08030-a186-4dc9-9739-825f686a3ffc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-24T10:16:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI2PR83MB0743:EE_
x-ms-office365-filtering-correlation-id: e39cb4c8-9f61-4600-3630-08dc9436f481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDF0cVRqVndZQlMvRmNxMURLaTh1TDVkZ0RSK2JNZnNwZ2N4Q1lLbFZaSHdT?=
 =?utf-8?B?YmpvS2NncDNyanM1aGJpQW5ETmhmTmNUdDFGV0Q0RzBzMjEzNVVKb1BFMGcz?=
 =?utf-8?B?S3l2am0wWVlHUGZOdkVBZWVwNWcyRjBYUXl5aXU5U1BVTnBITlZGQmNSOFpI?=
 =?utf-8?B?dTdNaFJkSk1zcy9tdVBnazEvS0dsNzRZd0FVQjl3ajdReUFCaGs3OTQvUzI1?=
 =?utf-8?B?TUd1VTYxQVZ2YkQ5c0JXeVFLVWhaZTE2MFBWbTF3eGUwWVBpOUp3dmEyOFZs?=
 =?utf-8?B?L3JGUTBocVc2LzJQNHVUR2JuUElHZ1lYWHVDckhHYkJzcENuelAyc1ROcUo1?=
 =?utf-8?B?VHVSV2VTWkx5WG5heUFPbUx5YlZMM0dhaEtteHJMREMraDBNMFRRRW13S3BM?=
 =?utf-8?B?aFJjR3d5dlpYMENiRkZ1N3lzS1dGUm9Vamg3c2Yyb0RJbzFzdDRjTmVTTGJ2?=
 =?utf-8?B?UWFycHJvTFg4VndXcXFZT1pzRHlBQXgwNlRTeWpMbGNOc2VPd1hoMDNzamI0?=
 =?utf-8?B?TDFvTW9ubWZOOFJBS0h2bnQ3YnlvMC8wVWo4by9tRXI2M2kvNDdzVURObldF?=
 =?utf-8?B?UEhpRjJMRXptT2NhUkZIT1ExMnFva2xoSG9pckdxYlJRMm1GYk5YZFhqNTNB?=
 =?utf-8?B?MVA5QlFKNkdJZGRYQjlCT095YjFxaUVrR2FHT2UxY2RaVFVsV2pCcUdCamgy?=
 =?utf-8?B?WFJUNk9mR1ZqR3JkNmcxemRHc2RTYzRYK1M5MHFFMVZNMXl2bUE3UTcyQ0Mr?=
 =?utf-8?B?QUdiN1ZNYmg4d0hOTWVqMVZqa1RjbjVQY2RBdXJZSUFtVjA0elFNcHVaUkhq?=
 =?utf-8?B?TEhZTVV4SGtBUjNUYXp3ZFRGQVdaVXpEbVJJN1hnSHVkZnAvMjIvQWROZmNm?=
 =?utf-8?B?WFBYQ0dCb1lIMTZzY0c5ZjNDcHloNVoyTkh5SlVjNjIycE1xZG9pdjB2OXhE?=
 =?utf-8?B?aDl5endpQVVrdWJ4V2FHcDZqYnlyNGNzZmtJRW9oVnJtSU1XZ3JwZTdkRG1y?=
 =?utf-8?B?ck4zSGxkUHhtTVBJMndsZU9kR2lEWE5XRWRLSzNxTHZNUXBSR1hYeitwQ3FW?=
 =?utf-8?B?L1dhNTJsNmFQMXdZdS81cVl2SHppM05jN1hTVVdIb2pHb0pwNG9uY29HS1Fn?=
 =?utf-8?B?SVl3SXNpb3RTdHMzZmp0RXU2RldjNHhsZHBOUkt0b0RvL0k5cFdVYVUyK1JW?=
 =?utf-8?B?blVEeHA1bXFXYUFwdmNoSUdWWDFiRnFqQnkzeVZYL1BhMnNmOUJHNUh4cFFk?=
 =?utf-8?B?U1kwakhURXg1QjRPdTJFWHhBR3phYkdVMUFQVTdLUWttMlpjNkFTbTNVS01j?=
 =?utf-8?B?R0JCRzNsQStaR1g3U29UYnByS3AvYXBDdFROQ2JoSGUwc2FmOVFKVDM1WHYx?=
 =?utf-8?B?VXpFVUpncVBVOTBuV25wMEJ1SWNJQzFUcWk5c2Y1Nm8wTmVCeFNJNWdUejZB?=
 =?utf-8?B?SmVwYUNNNlFJa0pTSmMzWDhsamNHTlZmdHphdC9GN2J4dzBEU3ZrUnYveEVn?=
 =?utf-8?B?UTY3M3gxSnpKT1JVQjlzNXZWMnFGenYwMVZZSjFwcGUyQndkSHVXZENHYzdp?=
 =?utf-8?B?WnRZVDBqRDR3M2E0Q3Z1ZlZBbmt1aDg0NlcySnJzWXR0Tkl6L0NGeGN6cSti?=
 =?utf-8?B?bmhmYXdseEFHRE5QOTFVOHMvaCtoYzhJeVlrYndKelZ4NE5hdDFFUG5vMmdl?=
 =?utf-8?B?TmpQWHQrcWg2UjRjaWdmY2VjSjBJNGcxNFhOSWNQQWtiWldpdDJzU2ZPQzgz?=
 =?utf-8?B?bHVNaVA0d3ZyQkR4cFFMSWFVcEgySmJwYk9JR0VoMDBrb3ZlMTVGVWo5aVox?=
 =?utf-8?B?Uks0eEQvbEcwR3BJNFV6dkJmcXUwemhsdzduZGgxYVV4djhwMTAwdlVFbmN3?=
 =?utf-8?B?S0U3c0NQdVdJR1NrRFl1TnBEdWk4b0RrcXMva01hSW5OTXNJMHFNTEFnUVly?=
 =?utf-8?Q?5J35WyTllPg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHA1UGMwWkZMbTRLWFROdWFRaFFzVGZGNVBRcFlqd3pUR0p4UVF6d3FkZ0V0?=
 =?utf-8?B?dWd1R0pBWjRaUFhVdlBGbzR2ejh4WXFJZGdBUkIvVWMvK0JLRW5nTTIxU3Fv?=
 =?utf-8?B?MnlGLzlTTTVaVWZUUTRrd1BUeW9tdHBFeEtRN0FwOTI4K256ZmpDWUt4Mk96?=
 =?utf-8?B?VWdKQ1hZYStkY2R2MG94R0FIZVJtWnhUNUNWYmpCRmFqYjBvSFpZR0VjTEIx?=
 =?utf-8?B?Tmtib0dmWkdMcjk0V1FwMXViK0cxdFg1M2Q1dDRUbUdqdVBYR3M4SEwwOWlG?=
 =?utf-8?B?TVBiMTBzTkltak5sM1YxMzZqejdaaEhaTzVoZXpheXZNQzJiNm5Td0lBWURn?=
 =?utf-8?B?eFFReHlJTVVSNzhGNWZpYTVUNXZjYkRrVnNUUXlIZTRtNVc1b202S1RYS3g1?=
 =?utf-8?B?TzVwMk9zeXppdzV4cDZISmlMK2diWEdRRlMrQTQvZjJEWUExOVFQby9rMFdJ?=
 =?utf-8?B?YVY4RHpSUGpNVFNhRW4zZTVJMmZ6bE54Q3pyVEU4NUw3QSsyMVh0dE5yay9R?=
 =?utf-8?B?S1JvcEttQXdSdGxSdFNyVTR0VVhoZkgva2J2dVI1Z0JVSk5pTG1BRUVteEg0?=
 =?utf-8?B?dlJVZmN6bXRHVHpSZWliMkhDR1d0U0thMzZ1R0RWelprZUwzMm5TYTUxekln?=
 =?utf-8?B?UlpWS3loYUlOM3ppeldoVitrRlVZVHgxTWQ1Sks2aUl5bVZDSlpaN3NhUUJp?=
 =?utf-8?B?eGlnNE1KSlRIYkN2Rk13UmZYZFdlNTNTZ2t4UzZwdmZiQ1h1RWg5WTVCN3A1?=
 =?utf-8?B?bC9IODQ5MjBKSGpPcHNKVG5DVVNhWFQ1cDBHR3RhQ2FvZFFMWVd4Z3ZLWXM1?=
 =?utf-8?B?bHRDTGRrWHN2UWtiakRDMFVWNFIraENnOGl0UTkvdVpkd3Y4Tkl5bFplRTNB?=
 =?utf-8?B?L08yZlN6ak4xeEs5dll4T29lYWFkNDRIL2s0RHBkRUVqb3lQZ1BFUmt1aTJW?=
 =?utf-8?B?aEpaKzc5WG1oa2pOR0cwaFJodHhINEJQMWxpVUJtQ1lRa0tyR1N3SzRVVEI5?=
 =?utf-8?B?WitEaGhPdW1lSmNHNFdObUtuQ2haUjNPRG9rYlJPR1lMVEQ5VlppbnJZWDEr?=
 =?utf-8?B?bk9sZXh3SklNTnBiaFFOMTIvOUl4YWViUHNwbXJ4NFpOM3loc3FpdCtFOGRL?=
 =?utf-8?B?MzF3b1hEWHh3a1VKYy96TkRkL055SDdGL2k2Mjd4dlNnL0YxY2E3aDZKbldI?=
 =?utf-8?B?QXRaa1BBZCtBRGh6cXlsMjE3bHo2cis2OERLS29BejFRblBRRyszQzNmWVBQ?=
 =?utf-8?B?OFR4amd2WTFkdGhISS9VY09TN0g2elNtUUV4WFd5UTViU0IwaEtwNW5jTFlV?=
 =?utf-8?B?QkR2MXZxalFzRUpkZlVmbjdwT0lwNlYrZytKR0hSRzBaU095R2laV0kvZWoy?=
 =?utf-8?B?TVBkNXJZOENqc2VlYjV6QjM0dUpHQ3h6dyt2NkYzbVNtcDJpZFpvdkxFZ0tS?=
 =?utf-8?B?R3phcy9wQUdudG5xSjFRQkljS09XSnlkVnZ6cWpISTc4Q2NncXl1bnVzaDZl?=
 =?utf-8?B?UG9vNlBUMWhHYkFQUFJyeDFlQ1VMRXp2VTBtMExEZ2xJaHNzNGFwSVpVNXU5?=
 =?utf-8?B?cFVzSStPMkxBZnpKVHNrNlJlSUoycGdwMkxUTjM0dytIQ2dyNllwd2dwZ2Mz?=
 =?utf-8?B?eG5scnFsMi9TN250OURjQk9WQVhwVENHNUFrMGlpRXZzZUpYb0hTSXQ3OXJp?=
 =?utf-8?B?YXo1R3BrRzhOZmluRmdmdDNEVGI3dEFhWTJqSEVYQzh1MHR1dFdmSFRkUW96?=
 =?utf-8?B?TndWOXBITzFEWURJcC9OSWFnRnExMS9taDBGT3JEemp4RklrYUlHc3pqQ0lL?=
 =?utf-8?B?SWZnd2hxS1dMMWx5R0YxeXd5V1FRdVhpU3VaZ0kxMFNKYlFnRXpLd2hSeU93?=
 =?utf-8?B?T1BrZnF5UjFxVnVoZ3FFM3Q4UFNrR0EzQ3Fjd1IxTENza0d5QXI5d3BOY3NN?=
 =?utf-8?B?c0Z6aWhrMmpJNmwxc2UzQjZqemY0MFdSdGV6eDNMV0lGNWJsaURXSW51SEtt?=
 =?utf-8?B?eWhKdE5VeWxhZGIxQkJSRWF2NHd3bk83RjkyN0VEN2E0ZWhMUGFHK0hGZjcw?=
 =?utf-8?B?T1B4dGtqMjFrSXpHWS8ybXJWcEJ5NTEvQmpOZUVpZkNXUTBIUVJmSkkxNThv?=
 =?utf-8?Q?GYd1jKHr8ASQ8IsVHBATslaSb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39cb4c8-9f61-4600-3630-08dc9436f481
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 10:18:13.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Cm2dC/rBKfPV73WGbJMeQwk2/JBVgHxhv2UjFaAkvAI2QKA2aq+zZED7xMy18PQGiDp5g12eMjk6I+qOPy1kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR83MB0743

PiA+IC0gICAgIGtmcmVlKG1hZGV2KTsNCj4gSSB0aGluayB5b3UgY2FuIGp1c3QgYXZvaWQgdXNp
bmcgYWRkX2ZhaWwgYW5kIGtlZXAvcmV0YWluIHJlc3Qgb2YgaW5pdF9mYWlsLCBpZHhfZmFpbA0K
PiBjb25kaXRpb25zIGluIG9sZCB3YXkgcmlnaHQ/DQoNCkkgZG8gYWdyZWUgd2l0aCBTYWkuIEkg
dGhpbmsgdGhlIHBhdGNoIGNhbiBiZSBqdXN0Og0KQEAgLTI3OTcsNyArMjc5Nyw4IEBAIHN0YXRp
YyBpbnQgYWRkX2FkZXYoc3RydWN0IGdkbWFfZGV2ICpnZCkNCiAgICAgICAgcmV0ID0gYXV4aWxp
YXJ5X2RldmljZV9pbml0KGFkZXYpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAg
IGdvdG8gaW5pdF9mYWlsOw0KLQ0KKyAgICAgICAvKiBtYWRldiBpcyBvd25lZCBieSB0aGUgYXV4
aWxpYXJ5IGRldmljZSAqLw0KKyAgICAgICBtYWRldiA9IE5VTEw7DQogICAgICAgIHJldCA9IGF1
eGlsaWFyeV9kZXZpY2VfYWRkKGFkZXYpOw0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAg
ICAgIGdvdG8gYWRkX2ZhaWw7DQoNCg0KLSBLb25zdGFudGluDQo=


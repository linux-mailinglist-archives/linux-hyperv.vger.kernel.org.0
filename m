Return-Path: <linux-hyperv+bounces-540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607057CB772
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 02:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7643B20EE2
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1415A3;
	Tue, 17 Oct 2023 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ir7AueCN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCF15A0
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 00:35:26 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483DA7;
	Mon, 16 Oct 2023 17:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUwNT65rdVNNKLkvO9dGVjyOuBhIwG99ri/Oz7fvJ0rMeDoRBFwjWYNE1w3YpVyInhNpagNveunxL9Y6V/aRolLXc/pDb2HJtF2C0ZxS07JyptEZTcp+djz5Gf3pFXIBujbAEBPpASTX/kws8LgO8QDnvcMRgl4brSQ8p2FzDgNfMic0xuvcObfLiKtpkWk66y3mNcxjMkz2wk2m7QCAUQvI6G3RMxfe58NaZ2tseil6iIUhno2bd4+q++OTk/w4FhGdjJTwoyZJ6/EhvP7NBiDz+LhARAvprWcXYMgSS+Pgj1gIm7U1+0dghOV0Fkfcm5DNHGzD7uR/Ie9qzq2Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RgZtQMhRXK3pd5fPBOB5sc+Fnjx6W1zclK5LVaR1WA=;
 b=nTpY7KK18dZ5MoEH0uMS9BMq7Q7Lgi8cCgN9n9aAbSxnn1/AyLQxtq1R5qW0W1ICpWUffm8sgdZaFSNH7Rd987ppCHCej0IBDM0pf/o9XcmtiVzk+pI4Z/XUw5aquZQC/jgaqfm3iGJNShCsxaq66sacW5gWB49zWtp57djdHnObSlM8GL3OzsiyWBFlA7PMcPNNpGpLwB6tyMRoyn6A0r53elO6MrL59j/ecbRX9byMulW27Ngx0u3Ox/iUUWl7oKvQ2eWCJBTOSNI54m0Ko5Tk/lQ9oI/vBgjeuGVb6qfkeA1mcQjA1dcmpw1ljl+IdCpW4QHgkI6M+rMhBVS4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RgZtQMhRXK3pd5fPBOB5sc+Fnjx6W1zclK5LVaR1WA=;
 b=Ir7AueCNHL0a2NErN/RKw+XpUxq/KRGFnvC0lJ9wjcspg0WFzPo1V1+L8bDI6Kn/fNoblK79OCo2hG8frNZwdcR2FX6UkkK0H43QjnWAggRB0+KBQrrrcK+HZi/K7XQZTx8FQWYM3/osaklUhJ7V3uVbGW/kr7+YLY5Z8toz5Hk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3695.namprd21.prod.outlook.com (2603:10b6:8:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3; Tue, 17 Oct
 2023 00:35:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4592:a0bb:e4ef:3093]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4592:a0bb:e4ef:3093%5]) with mapi id 15.20.6933.003; Tue, 17 Oct 2023
 00:35:21 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while changing
 encrypted state
Thread-Topic: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while
 changing encrypted state
Thread-Index: AQHZ8wGfg5XItVQuiU6MiMRAAvPq57A2ttUAgAAoLICAABfDQIAWPneg
Date: Tue, 17 Oct 2023 00:35:21 +0000
Message-ID:
 <BYAPR21MB168854B263AD8985210E4F70D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
 <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
 <c9a06bd0-09aa-5e4b-e2cb-63ebcc93757e@amd.com>
 <2edc7c71-935e-0185-e547-587170a054ff@amd.com>
 <BYAPR21MB1688DA9620895DD50BEA99D6D7C5A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To:
 <BYAPR21MB1688DA9620895DD50BEA99D6D7C5A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f09b5bea-5e2c-4948-86ff-1c5598793ab8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-02T20:24:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3695:EE_
x-ms-office365-filtering-correlation-id: e1ff7da5-f869-4b09-d147-08dbcea8f24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1wEPi+iZns9OFc7bgrjFdMAhSdi8AurD2UhMJmJvuZL+rSRdPpXFAklNRMYcHxiIBbt87SHvcXXKnAePm8L1PI8DorRTWfzxDIECs/pBgq17zUtjtFVqIQspZqbJIzX9beAc//Fv3Zj6EpXdEAyLLabes8QH3M/+bwAHaLHul5AjAhOGt/XZUbEvLsdfbTdQoBNNxCgZYWx+cRk+MwxhRZ4PM2nBVwhOcBdPyEBdyPoPGFagMCMPg7OD/OJyAzyBsfD1mMEE0vwH725O/7iiHC2Re02wF97/kRYzKI86buegBSm34b+yb+rHtRPvjVJj/FDa/tismcHo297k8QbrQzxk3U3KOGQe7IQAF0MVsr1BpjSqp3B+KokEvBVa4u5ffCpakoShiQaHgh8c9XIoy0b6A+MO4+2imA+E2MI2h/nOCNEhKyBMrisLoOxYkc1upHiFF+GC0Ck2vweAvHEdsYsd8H6JpbjTb5/aNMfpvalQXQ9MerUT9a56psTQ0OxpWNYFt0AyDZ9bR4F+eE+gjNw0TAsR5zTEfJfJqDE+WZPIAO8IB5P32WNnIhw4FSUBcLdkejC5fCiB1IgGMr8wdKxnaT1a4a3lHvxt2WaYqHr8dS/4DY7ZHS2+GUqNyDJhmEsMOnIVmkaNTDMOi+T3c1A8UWsKcYwEVbm7wxqbsu3mUAxXGDafpIGuf7gtyT/s
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(33656002)(38100700002)(38070700005)(55016003)(6506007)(7696005)(9686003)(71200400001)(53546011)(8676002)(8936002)(83380400001)(52536014)(5660300002)(2906002)(26005)(7416002)(41300700001)(66946007)(316002)(66446008)(66556008)(66476007)(76116006)(64756008)(110136005)(478600001)(10290500003)(8990500004)(921005)(82950400001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2ZMRVFQNjE5d3ZZWlFocTREYnNXVUg4Szh3U1RRUlowd1NTZHpya1YzdzBx?=
 =?utf-8?B?WFpJblFHd3hVTEd4dFgwakpmby8wU3VXZy8yWWhwb1FLUDNlaVhnOWV4MG9V?=
 =?utf-8?B?MEpGeHppSEp5Tnp2UWJOQllhWXVVVWpGVUd0Zk9EemZ3bjI0NkhGVk5xNnlF?=
 =?utf-8?B?cFZKWXc2cXRiTTJ3UGN5K0tuNk93UTdvNS9BRzIrV0ZraHBEL2RpMmdPdUVY?=
 =?utf-8?B?ZGU5Vnk3L1dFTXRueHhEWGsyaWVvL1cvdC9qcWlZNmwzcTFKZmpJUXM2UFdJ?=
 =?utf-8?B?c2xWajFjMFdzK0paT1Jud3dtNytudTdvZ0t6b1JtbUpvT1ViVUpBeUlrbVJS?=
 =?utf-8?B?dnFJZ0VNSWRKSHRQQkRGNFVBNjdpdDhZcmtQRjlyUk1xOG5NQ05xbmZvNXFT?=
 =?utf-8?B?Ynd0cUVUa0g1WGVlL3RUMnpnNHF3RSt1TE54aXkva2ZoN1Z0ZUhBWHVTQmds?=
 =?utf-8?B?SVZYZmdHczMyTW11QUltRTZ6L25zQjl6K1I4MzBnWGRpd0ZjUGNJUnhMY1VS?=
 =?utf-8?B?WUhXb2tuNHhRazNPK2NRZDhhNm5JTklIWHNjbnRZL0ZlRVZZN21ScmhUZ3pH?=
 =?utf-8?B?OWc3MWQ0SExnaytQNDQ5Q2FCb0lZY2dIY3VMUkc4V0NIcWpEM1RpMEtYZ2Z1?=
 =?utf-8?B?ZmtoTWRwU3pOcGR2bEM5eTJ3WXNEYit2bU16Ny9JcTBQdUNNc2Z1SkFFQkY1?=
 =?utf-8?B?bFVaSFlwMzJpQ2pEQXRrNnppVGNSMFNnQ0pJdkttcHM1OGNqNVorQndFcGI3?=
 =?utf-8?B?ai85RnRDTHFuVkp0VWwwbFI5Z3pDQnJHdERWcTZzZWx6VXVBT0laT3BWM0di?=
 =?utf-8?B?aFRzdjJyRllLTkRvOEhzN3hzd0xSdGZEZlNvbVp4TE1pYU9WS1pxWitYWFdE?=
 =?utf-8?B?VUE0bUcvZ1JUbUhWU2lvRmo3aGMyMEsrWXR4VHowM0RwM25rSDJaQ1MvZXQv?=
 =?utf-8?B?dzFZVmpRanA5clByd0cxU1JlRTUrbXlZQ0l2cVIxYkNvVVVyUDRHc3VsUjBs?=
 =?utf-8?B?OVJlZmpnSEIwZHJOT1VuYmRBeXAxY01KM0xqK2FtTG1WWGNFM0tqQ3gvWk52?=
 =?utf-8?B?dzM0Zk1wdVJvL0dSb1lVT1ZOVjdpRlQvT2lwdC9VdkNVVzcwK0dZQ211bE03?=
 =?utf-8?B?WWhZUjg3K01qOFpkUXpDdGlkaW1semZBUEVWKzdJUzhUMUkyczhJdVJGU1hH?=
 =?utf-8?B?YmJKSk5kd015dlNjV1puRzhwSDUyOGVGZmc1QlJneGh4dnZ1S0l3YWM5S05q?=
 =?utf-8?B?TjFoVDRsNUdhRWtQR1FocEdQRWFyZmplNWtJekdHRGFFM1lqYmRDUmIwSzY1?=
 =?utf-8?B?b1lRUkVCUTVEWUZTZkhVWlBEYnhQZ24xZXVEV0QvcTNuL0FERVJaWFEyRGsw?=
 =?utf-8?B?aGhTTzhNRVZMN2xZendXakUrbVNEQ2Y5MTBxUS9IUUZicm1pMmJQK0lFYXdO?=
 =?utf-8?B?V09jNVFNc29TMEtUalFJRExzUVVqUndUeUtEcHlEVjFpdUJUc1NFVC9YdWRX?=
 =?utf-8?B?L2JudHdEZityZWtYNlNValZmb055TTNSdEdjZTdmWW1jZWZwN3AzeHBzQm9a?=
 =?utf-8?B?N2J6MkFGYzRnTnJveEoxcnRIR2twQ1MvVnF2TGZ6d2doTXZwTU5SWS9DcDNF?=
 =?utf-8?B?YVVWa05MZFAxQUVmd3JxMFpQMXBjaGZDekpPbXBZeDh4VzRjSnAwTEI2b3hu?=
 =?utf-8?B?WmhEL2tGck5OTk5pVWYxN1RxcVF3c0ZPYVU0bjVhUHJrUDRGb0hlejhmSUtp?=
 =?utf-8?B?MzZ1YU5IbklNSEdzNGIvd3d2dmdRUVk2VDVMZFhqKzljcnZlcWNNZkx3b0VK?=
 =?utf-8?B?VFBMYWNjMFFDNGR3d2IwMXY2YXBuTzlKWFFpeHRaRFJKY1VkbGdPd2VoS2o0?=
 =?utf-8?B?UXgyalFtcTFiRy9hdDQ5eGpjaGVhRFlIWW1LRlNudTNHN3hjeFRLMVhvY2FV?=
 =?utf-8?B?cnlEQkRKbCtvWUJFcGhud09abWFLRkFVajFlSmdxbWpVZ3NQbVRjTm5ZQWpm?=
 =?utf-8?B?d3BhS044MzhJanVlRVdPSmtTZ3h3eHoxM25LVjRoNy9JOGlDZEZZMjJFSHRo?=
 =?utf-8?B?RUFzK01jZStBYnFyUkc1NlZsV1R2Wnd6dE10dzdFbllCcHVhcjE3NmtlWFNL?=
 =?utf-8?B?MU5XdUM4TW1PN2xxeU0xVWJUbW14TmFKWERsSzZWZE1zMFBlNlJ6UmdHQWxo?=
 =?utf-8?B?M3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ff7da5-f869-4b09-d147-08dbcea8f24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 00:35:21.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1O8bcNBneN5AwmBeD0GAEhbFjCjJmZFae8wty9M6XxxR4edTcS4KGz9RJOg/cQAEbsZRjqlgyyhL7X8mI7MACdPXTP3UPCGDpqfeK/A2Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3695
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogTWljaGFlbCBLZWxsZXkgKExJTlVYKSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gU2Vu
dDogTW9uZGF5LCBPY3RvYmVyIDIsIDIwMjMgMTo0MyBQTQ0KPiANCj4gRnJvbTogVG9tIExlbmRh
Y2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDIsIDIw
MjMNCj4gMTE6NTkgQU0NCj4gPg0KPiA+IE9uIDEwLzIvMjMgMTE6MzUsIFRvbSBMZW5kYWNreSB3
cm90ZToNCj4gPiA+IE9uIDkvMjkvMjMgMTM6MTksIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+
ID4+IEluIGEgQ29DbyBWTSB3aGVuIGEgcGFnZSB0cmFuc2l0aW9ucyBmcm9tIGVuY3J5cHRlZCB0
byBkZWNyeXB0ZWQsIG9yIHZpY2UNCj4gPiA+PiB2ZXJzYSwgYXR0cmlidXRlcyBpbiB0aGUgUFRF
IG11c3QgYmUgdXBkYXRlZCAqYW5kKiB0aGUgaHlwZXJ2aXNvciBtdXN0DQo+ID4gPj4gYmUgbm90
aWZpZWQgb2YgdGhlIGNoYW5nZS4gQmVjYXVzZSB0aGVyZSBhcmUgdHdvIHNlcGFyYXRlIHN0ZXBz
LCB0aGVyZSdzDQo+ID4gPj4gYSB3aW5kb3cgd2hlcmUgdGhlIHNldHRpbmdzIGFyZSBpbmNvbnNp
c3RlbnQuwqAgTm9ybWFsbHkgdGhlIGNvZGUgdGhhdA0KPiA+ID4+IGluaXRpYXRlcyB0aGUgdHJh
bnNpdGlvbiAodmlhIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgb3INCj4gPiA+PiBzZXRfbWVtb3J5
X2VuY3J5cHRlZCgpKSBlbnN1cmVzIHRoYXQgdGhlIG1lbW9yeSBpcyBub3QgYmVpbmcgYWNjZXNz
ZWQNCj4gPiA+PiBkdXJpbmcgYSB0cmFuc2l0aW9uLCBzbyB0aGUgd2luZG93IG9mIGluY29uc2lz
dGVuY3kgaXMgbm90IGEgcHJvYmxlbS4NCj4gPiA+PiBIb3dldmVyLCB0aGUgbG9hZF91bmFsaWdu
ZWRfemVyb3BhZCgpIGZ1bmN0aW9uIGNhbiByZWFkIGFyYml0cmFyeSBtZW1vcnkNCj4gPiA+PiBw
YWdlcyBhdCBhcmJpdHJhcnkgdGltZXMsIHdoaWNoIGNvdWxkIGFjY2VzcyBhIHRyYW5zaXRpb25p
bmcgcGFnZSBkdXJpbmcNCj4gPiA+PiB0aGUgd2luZG93LsKgIEluIHN1Y2ggYSBjYXNlLCBDb0Nv
IFZNIHNwZWNpZmljIGV4Y2VwdGlvbnMgYXJlIHRha2VuDQo+ID4gPj4gKGRlcGVuZGluZyBvbiB0
aGUgQ29DbyBhcmNoaXRlY3R1cmUgaW4gdXNlKS7CoCBDdXJyZW50IGNvZGUgaW4gdGhvc2UNCj4g
PiA+PiBleGNlcHRpb24gaGFuZGxlcnMgcmVjb3ZlcnMgYW5kIGRvZXMgImZpeHVwIiBvbiB0aGUg
cmVzdWx0IHJldHVybmVkIGJ5DQo+ID4gPj4gbG9hZF91bmFsaWduZWRfemVyb3BhZCgpLsKgIFVu
Zm9ydHVuYXRlbHksIHRoaXMgZXhjZXB0aW9uIGhhbmRsaW5nIGNhbid0DQo+ID4gPj4gd29yayBp
biBwYXJhdmlzb3Igc2NlbmFyaW9zIChURFggUGFyaXRpb25pbmcgYW5kIFNFVi1TTlAgaW4gdlRP
TSBtb2RlKS4NCj4gPiA+PiBUaGUgZXhjZXB0aW9ucyBuZWVkIHRvIGJlIGZvcndhcmRlZCBmcm9t
IHRoZSBwYXJhdmlzb3IgdG8gdGhlIExpbnV4DQo+ID4gPj4gZ3Vlc3QsIGJ1dCB0aGVyZSBhcmUg
bm8gYXJjaGl0ZWN0dXJhbCBzcGVjcyBmb3IgaG93IHRvIGRvIHRoYXQuDQo+ID4gPj4NCj4gPiA+
PiBGb3J0dW5hdGVseSwgdGhlcmUncyBhIHNpbXBsZXIgd2F5IHRvIHNvbHZlIHRoZSBwcm9ibGVt
IGJ5IGNoYW5naW5nDQo+ID4gPj4gdGhlIGNvcmUgdHJhbnNpdGlvbiBjb2RlIGluIF9fc2V0X21l
bW9yeV9lbmNfcGd0YWJsZSgpIHRvIGRvIHRoZQ0KPiA+ID4+IGZvbGxvd2luZzoNCj4gPiA+Pg0K
PiA+ID4+IDEuwqAgUmVtb3ZlIGFsaWFzaW5nIG1hcHBpbmdzDQo+ID4gPj4gMi7CoCBGbHVzaCB0
aGUgZGF0YSBjYWNoZSBpZiBuZWVkZWQNCj4gPiA+PiAzLsKgIFJlbW92ZSB0aGUgUFJFU0VOVCBi
aXQgZnJvbSB0aGUgUFRFcyBvZiBhbGwgdHJhbnNpdGlvbmluZyBwYWdlcw0KPiA+ID4+IDQuwqAg
U2V0L2NsZWFyIHRoZSBlbmNyeXB0aW9uIGF0dHJpYnV0ZSBhcyBhcHByb3ByaWF0ZQ0KPiA+ID4+
IDUuwqAgRmx1c2ggdGhlIFRMQiBzbyB0aGUgY2hhbmdlZCBlbmNyeXB0aW9uIGF0dHJpYnV0ZSBp
c24ndCB2aXNpYmxlDQo+ID4gPj4gNi7CoCBOb3RpZnkgdGhlIGh5cGVydmlzb3Igb2YgdGhlIGVu
Y3J5cHRpb24gc3RhdHVzIGNoYW5nZQ0KPiA+ID4NCj4gPiA+IE5vdCBzdXJlIHdoeSBJIGRpZG4n
dCBub3RpY2UgdGhpcyBiZWZvcmUsIGJ1dCBJIHdpbGwgbmVlZCB0byB0ZXN0IHRoaXMgdG8NCj4g
PiA+IGJlIGNlcnRhaW4uIEFzIHBhcnQgb2YgdGhpcyBub3RpZmljYXRpb24sIHRoZSBTTlAgc3Vw
cG9ydCB3aWxsIGlzc3VlIGENCj4gPiA+IFBWQUxJREFURSBpbnN0cnVjdGlvbiAodG8gZWl0aGVy
IHZhbGlkYXRlIG9yIHJlc2NpbmQgdmFsaWRhdGlvbiB0byB0aGUNCj4gPiA+IHBhZ2UpLiBQVkFM
SURBVEUgdGFrZXMgYSB2aXJ0dWFsIGFkZHJlc3MuIElmIHRoZSBQUkVTRU5UIGJpdCBoYXMgYmVl
bg0KPiA+ID4gcmVtb3ZlZCwgdGhlIFBWQUxJREFURSBpbnN0cnVjdGlvbiB3aWxsIHRha2UgYSAj
UEYgKHNlZSBjb21tZW50cyBiZWxvdykuDQo+ID4NCj4gPiBZZXMsIHRoaXMgc2VyaWVzIHJlc3Vs
dHMgaW4gYSAjUEYgYm9vdGluZyBhbiBTTlAgZ3Vlc3Q6DQo+IA0KPiBCdW1tZXIgOi0oICAgIElu
dGVyZXN0aW5nbHksIGFuIFNOUCBndWVzdCBvbiBIeXBlci1WIHdpdGggYSBwYXJhdmlzb3INCj4g
d29ya3MsIHByZXN1bWFibHkgYmVjYXVzZSB0aGUgcGFyYXZpc29yIGlzIGRvaW5nIHRoZSBQVkFM
SURBVEUgd2l0aA0KPiBhIGRpZmZlcmVudCBndWVzdCB2aXJ0dWFsIGFkZHJlc3MgZm9yIHRoZSBw
aHlzaWNhbCBwYWdlLiAgVERYIG9wZXJhdGVzDQo+IG9uIHBoeXNpY2FsIGFkZHJlc3NlcywgYW5k
IEkndmUgdGVzdGVkIHRoYXQgaXQgd29ya3MuDQo+IA0KPiBUaGUgc3BlYyBmb3IgUFZBTElEQVRF
IHNheXMgaXQgcGVyZm9ybXMgdGhlIHNhbWUgc2VnbWVudGF0aW9uDQo+IGFuZCBwYWdpbmcgY2hl
Y2tzIGFzIGEgMS1ieXRlIHJlYWQsIHNvIGluZGVlZCwgdGhlICNQRiBpcyBleHBlY3RlZC4NCj4g
QnV0IGluIHRoZSBzcGVjLCB0aGUgcHNldWRvLWNvZGUgZm9yIFBWQUxJREFURSB1c2VzIHRoZSBH
VUVTVF9WQQ0KPiBvbmx5IHRvIGRlcml2ZSB0aGUgR1VFU1RfUEEgYW5kIHRoZSBTWVNURU1fUEEu
IFRoZSBHVUVTVF9WQSBpc24ndA0KPiBvdGhlcndpc2UgcmVsZXZhbnQsIHNvIGFueSBHVUVTVF9W
QSB0aGF0IHZhbGlkbHkgbWFwcyB0byB0aGUgR1VFU1RfUEENCj4gd291bGQgd29yaywgYXMgbG9u
ZyBhcyB3ZSBjYW4gYmUgYXNzdXJlZCB0aGF0IGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKQ0KPiB3
b24ndCB0b3VjaCB0aGF0IEdVRVNUX1ZBLg0KPiANCj4gTGV0IG1lIHRoaW5rIGFib3V0IGlmIHRo
ZXJlJ3MgYSBub3QtdG9vLWhhY2t5IHdheSB0byBtYWtlIHRoaXMgd29yaw0KPiB3aXRoIHNvbWUg
dGVtcG9yYXJ5IEdWQS4NCj4gDQoNCkl0IHNlZW1zIGxpa2UgdGhlcmUgYXJlIHR3byBwb3NzaWJs
ZSBhcHByb2FjaGVzIHRvIG1ha2UgdGhpcyB3b3JrOg0KDQoxLiAgQ3JlYXRlIGEgdGVtcG9yYXJ5
IHZpcnR1YWwgbWFwcGluZyBpbiB2bWFsbG9jIHNwYWNlIGFuZCBwYXNzDQp0aGF0IHZpcnR1YWwg
YWRkcmVzcyB0byBQVkFMSURBVEUuICAoQnV0IG9ubHkgZG8gdGhpcyB3aGVuIFBWQUxJREFURQ0K
aXMgYmVpbmcgdXNlZCBmb3IgcHJpdmF0ZSA8LT4gc2hhcmVkIHRyYW5zaXRpb25zLCBhbmQgbm90
IGZvciBtZW1vcnkNCmFjY2VwdGFuY2UuKSAgVGhlIHRlbXBvcmFyeSBtYXBwaW5nIGlzIHVwZGF0
ZWQgd2l0aCBlYWNoIGludm9jYXRpb24NCm9mIFBWQUxJREFURS4gIFRvIG1ha2UgdGhpcyB3b3Jr
LCB0aGUgdGVtcCB2aXJ0dWFsIGFkZHIgbXVzdCBiZSBhbGlnbmVkDQpvbiBhIDIgTWVnIGJvdW5k
YXJ5IGFuZCBtdXN0IGhhdmUgYSBndWFyZCBwYWdlIHByZWNlZGluZyBpdCBzbyB0aGF0DQpsb2Fk
X3VuYWxpZ25lZF96ZXJvcGFkKCkgY2FuJ3Qgc3R1bWJsZSBpbnRvIHRoZSB0ZW1wb3JhcnkgbWFw
cGluZy4NCkkndmUgd3Jlc3RsZWQgd2l0aCBhIGZldyBhcHByb2FjaGVzIHRvIGNvZGluZyB0aGlz
IG92ZXIgdGhlIHBhc3QgdHdvDQp3ZWVrcywgYW5kIGhhdmUgc29tZXRoaW5nIHRoYXQncyBub3Qg
dG9vIGJhZC4gICBUaGlzIGFwcHJvYWNoDQpjZXJ0YWlubHkgdGFrZXMgc29tZSBhZGRpdGlvbmFs
IENQVSBjeWNsZXMuICBJJ3ZlIHRlc3RlZCBkb2luZyB0aGUNCnRlbXAgbWFwcGluZyBpbiB0aGUg
Y29udGV4dCBvZiBhIEh5cGVyLVYgdlRPTSBWTSwgYnV0IGRvbid0IHNlZQ0KYW55IG1lYXN1cmFi
bGUgaW1wYWN0IG9uIGJvb3QgdGltZSwgZXZlbiB3aGVuIGNvbnZlcnRpbmcgYSAxIEdieXRlDQpz
d2lvdGxiIHNwYWNlIGZyb20gcHJpdmF0ZSB0byBzaGFyZWQuICBJJ20gc2V0dGluZyB1cCBub3cg
dG8gdGVzdA0KaW4gYSByZWd1bGFyIFNOUCBWTSB3aGVyZSBzbnBfZW5jX3N0YXR1c19jaGFuZ2Vf
ZmluaXNoKCkgaXMgdXNlZCwNCnRvIGhhdmUgZW5kLXRvLWVuZCBjb25maXJtYXRpb24gdGhhdCBp
dCByZWFsbHkgZG9lcyB3b3JrLg0KDQoyLiAgQSBjb21wbGV0ZWx5IGRpZmZlcmVudCBhcHByb2Fj
aCBpcyBmb3IgX19zZXRfbWVtb3J5X2VuY19wZ3RhYmxlKCkNCnRvIGNsZWFyIGFuZCByZXN0b3Jl
IHRoZSBQUkVTRU5UIGJpdCBvbmx5IHdoZW4gUkVGTEVDVF9WQyBpcyBzZXQgaW4NCnRoZSBNU1Jf
QU1ENjRfU0VWLCBhbmQgdGhlIGVxdWl2YWxlbnQgb24gVERYLiAgVGhpcyBpcyB0aGUgY2FzZSB0
aGF0J3MNCnByb2JsZW1hdGljIGZvciBkb2luZyB0aGUgbG9hZF91bmFsaWduZWRfemVyb3BhZCgp
IGZpeCB1cCBpbiB0aGUgU05QDQojVkMgb3IgVERYICNWRSBleGNlcHRpb24gaGFuZGxlci4gICBJ
IHRoaW5rIHlvdSBzYWlkIHNvbWUgYWRkaXRpb25hbCB3b3JrDQp3YXMgbmVlZGVkIGZvciB0aGUg
Zml4dXAgdG8gYmUgZG9uZSBwcm9wZXJseSBpbiB0aGUgU05QICNWQyBjYXNlLCBzbyB0aGF0DQp3
b3VsZCBoYXZlIHRvIGJlIGRvbmUuICAgVGhlIGNsZWFyZWQgUFJFU0VOVCBiaXQgaXMgaGFuZGxl
ZCBieSB0aGUNCnBhcmF2aXNvciBiZWNhdXNlIHRoZSBwYXJhdmlzb3IgYWxyZWFkeSBoYXMgYSB2
aXJ0dWFsIG1hcHBpbmcgdG8gcGFzcw0KdG8gUFZBTElEQVRFLg0KDQpBbnkgdGhvdWdodHM/ICBJ
J2xsIHRyeSB0byBnZXQgdGhlIGNvZGUgZm9yICMxIHBvc3RlZCBpbiB0aGUgbmV4dCBmZXcNCmRh
eXMsIHNvIHlvdSBjYW4ganVkZ2UgdGhlIGxldmVsIG9mIGFkZGl0aW9uYWwgY29tcGxleGl0eSB0
byBtYW5hZ2UNCnRoZSB0ZW1wIHZpcnR1YWwgbWFwcGluZy4NCg0KTWljaGFlbA0K


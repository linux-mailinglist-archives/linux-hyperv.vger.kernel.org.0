Return-Path: <linux-hyperv+bounces-550-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D467CD174
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Oct 2023 02:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E51C1C208D0
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Oct 2023 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CB63B;
	Wed, 18 Oct 2023 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OjS/1/BR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79122630;
	Wed, 18 Oct 2023 00:51:54 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB3F9;
	Tue, 17 Oct 2023 17:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab52gieZc/AVOtP26r7w/wjoHLrux6raLf8gcQ53DQDgRwxRgoMw+YAzmww8hju2d+g0B77vJf13fjwGuHfGchfaWqKXaHDbJ2U2OYXyLaJJ27HJcQG4+cdRRNsa9J6KxqJa6Iuv8j6trdh2MfMcXDwX2CLu6iVSsV7+6P90JjdZTy+gNa9S2Jkxg+usq+dmaSsPyRQcqfamFfVdhD99kWrVFFL4//rjtFs+x5cAsBJtgplufr2rdTMEKNahHAbQEOJthX3L2FPTfuhbet6IvXEvDblK+mMGtumFf/sqb+nsEXFvL4bmH3/kALJXFmNeOISBrtkvdAVQkNDDoAYztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzgcUWck8G9BKQ09LdsjTZ0E//YAYybz+FkN8S872fU=;
 b=iTVd5BpLx9S+1RLZjNfE1M/JGTx8wPR6q2JwroyWa0rAuheSFhae6IfFu9OliU6PttSmUqMP6lm7UhIbL+j2i5mmsqRCHol9XOgRfCfb8jLpSTSDV2h18azcGlhrKLa8nUMNpkgH/wGTCqn+mQkTMB19AsBOE1HwKL32kuGMSpzgWRAan1Z1HmD84ezc2ZOOD3fjeJ1jf/O8N68MkCIEWqcQzuWbk1+8KBA2YgY9j2wQrSl5k2r8SPhoPr+t23bJiw4tLI8gzqGLZHkzWSnNXQS4QKRC8e0c/pOvf1Yok39Hkvqeuno4qMaKEuQ1pQj18qLNx6OmhLMf2c4vmBnZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzgcUWck8G9BKQ09LdsjTZ0E//YAYybz+FkN8S872fU=;
 b=OjS/1/BRwOeKyrJncStQTBX81InQ0l8KwIoUOdQPLRevE0pzLpEpfp2lXegfHOmW2TGoqynE1ANyMFmqH4B7YcikDBpD4dUTPCh/9Myyc2yXTJq+r1QIqgeQjJmryRO2NTKgCgzmcsw4g7fKUxMx2BW/h+Ql8WpJwe2f77fKskA=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SJ1PR21MB3699.namprd21.prod.outlook.com (2603:10b6:a03:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4; Wed, 18 Oct
 2023 00:51:49 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bc89:f4fb:3df6:66d9]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bc89:f4fb:3df6:66d9%4]) with mapi id 15.20.6933.003; Wed, 18 Oct 2023
 00:51:48 +0000
From: Long Li <longli@microsoft.com>
To: Ajay Sharma <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>
CC: "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Dexuan Cui <decui@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Topic: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Index:
 AQHZ4au7TMkLuozgYUSHh+eTjjozY7AVlLmAgABrhYCAClDGgIAs6CIAgACgG4CAALlMgIAAYKXQ
Date: Wed, 18 Oct 2023 00:51:48 +0000
Message-ID:
 <PH7PR21MB32630E198B05427FC4D6D785CED5A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
 <20230918082903.GC13757@unreal>
 <MN0PR21MB3606BE5B57AF1FEE85915F3AD6D7A@MN0PR21MB3606.namprd21.prod.outlook.com>
 <20231017074821.GB5392@unreal>
 <MN0PR21MB360682AE32CBD7B26DE435BDD6D6A@MN0PR21MB3606.namprd21.prod.outlook.com>
In-Reply-To:
 <MN0PR21MB360682AE32CBD7B26DE435BDD6D6A@MN0PR21MB3606.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=967a5d7d-5e48-45b9-9739-1af9aba6fc91;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-17T18:46:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SJ1PR21MB3699:EE_
x-ms-office365-filtering-correlation-id: 6626fadf-c045-4a10-a898-08dbcf7468f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EVQZc5HkNKif/pWSrFv6ZJ+HISVSiJEymicXuezapHOPX0wGye0HM5TUOToDiXn17rMNDAgjHNuCt+XaWIaxUCnFQJL/zYKrFOh0nfPAibzDECl4Bhi07/XjU5IjoxcG4rPhaWjan1vzJ3aWQqUBEtkozi4QR7e01AVaveC88pI/NFuG31Ai+RF1F74NkSt1P9hd29LaFXkma88D3v4Rd4AjfTUYzAeaP7H+0uh7I4Fos2ydJKBqXTCo0IxJ3jApq9X6s/BLFSDNOXAWUypBwbbNL5/ak81w75I0Pk9XCJ9s+DOnebiVftyYB2OOIL84k8lr7kxiq+ioa3ZSgYWFTjhH5S2A+93qlR+fWNWFinAdQoOuywJb0QKCVKuIoJ5V4uUBuqL2N6+tuucAZ3HWQtDc129ybMmIdl4wgJ7eDFXBQbze/qXsDkafvEQT/zNfdiosc5JeGqfyZuKVwS5jsfPS8Y6SEmvarqhXCxc+mlGHk415T0qgc6AAhZuMQCbXeHKzf2hEWAf1t7DOQGIl0BEGf75XzuhXEL42XT1xi2onkzbwpSQUmJn5+SjMrFp1+CESDrA7MgOchwQ2zI3yJ126WZKUABRAk+7V/vcQnUj3m029kl7OOOOqEHdvqaR5EFxgCQz2Ob3DPkBLwVXKYX7tQBumtFyqWvs+EZFOe9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82950400001)(82960400001)(1700900015)(55016003)(83380400001)(41300700001)(8936002)(66946007)(54906003)(76116006)(4326008)(66556008)(66476007)(66446008)(8676002)(7416002)(5660300002)(86362001)(10290500003)(64756008)(2906002)(316002)(33656002)(8990500004)(52536014)(110136005)(478600001)(53546011)(7696005)(71200400001)(6506007)(122000001)(38070700005)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVlmWjk3N1hJc05sVGxlNFRkYjJwYkl6eXJ1RWF3MFRhT1VRdlVKNXBSaEx1?=
 =?utf-8?B?NFNuSnV6TUJtelZjQlRTNE9tSDE2dnFsS2t4ZEZhTTRxamU2dXRVUVN3Ung0?=
 =?utf-8?B?SjdDbWlhTWREaDJLcU50cU9kZnNNRE1MUTBJLzJTek9vVkR1b2ZQVGRMcDhJ?=
 =?utf-8?B?bVdCaDNqcDQxMjVpa21IYW9aa1hLZDNDU1pmN0p3TUFzdktNSlZiaW1FTlNn?=
 =?utf-8?B?M2VvaG1LdThvakVZQ1ZnTnNkTTZuRm11aTNIa1BTbE9vUnVyaExubU9rakZU?=
 =?utf-8?B?ME1BTkhpY2VSTHorazE4dUhaWkZESVdKTGFpWEw1andhN3dzREVJR3R3YzVH?=
 =?utf-8?B?bFM3Y0FCWWdxS053SnE4WjJ4ZVQyNzNFcFVoY1p3b0tpZGJESVdwVktrN0xV?=
 =?utf-8?B?dDVpR0RFazJVNUV1dndTaDB4aWd0S1lKKzM0TlFxTHF0RGNiaTVCY1QyWExs?=
 =?utf-8?B?NEl6RTRoMGgyQTVOcHBTMzRzSUsySitJdmE1ay93QU5sTmV6d2IyZG5QSU9u?=
 =?utf-8?B?cVArUEwwbkw1Y3BSOHpma3JYcnl0aUVXemd1cUsyYUhCNWZ4aE5sWjJuUE9t?=
 =?utf-8?B?Nm5FZ01uUzlNcWkyNHVlN0RTY251YTJ0VjRSN0JBUjFMa2s3YWQ1bUZLY3ZF?=
 =?utf-8?B?cTI1U2dpWnZ4UVJTM2ZDZFVhOWhIUUJzTHg0eWpXVUhpR3RZKzBDbGIrNko4?=
 =?utf-8?B?NWdTZDBkVW5hUSsrL1VuWGRBU2s5N2RCK1p6V3ErZjRCQktHN2JmWFE1K3Yw?=
 =?utf-8?B?ODc4emF2TGw5QVVKUkd0b2RaOHZ1cmlCdlcwNzdsRk9pWFFiVEFEN2dWbDhX?=
 =?utf-8?B?aE5KQ3l4MDVDUjdWcE04RmFEMDNncGZ0MjNYeWttTVZzclRlR1dWMWZ3cjAx?=
 =?utf-8?B?SjZHYjNSL294Qlh5K2tENUx0TnhjVGE4RFVKUDhUbUpJa0lrQjZKWGRCZUZD?=
 =?utf-8?B?SHRyU1BpTzdkU1JCeXdDMDEvbGxsZVhVNGNzYmd1Q3U1eWFRdUV0RkJzTTd1?=
 =?utf-8?B?ekJTd0dNTjFCZGhuaERFbzByOFdKSytYTVUwUmw4ZmdUalVpVHY5Ty9uK25S?=
 =?utf-8?B?VzZMTTMzQ1FFcTZuWWdLSXFiSytvdHZuMFV6K2xWemg3Z0ZWVS83K3pmdHZa?=
 =?utf-8?B?OXJFMUhDUU9zcFNpOTcxblpOY3NSM3VhYTVDeitVMzRtODRURXdTN3Z1RGhx?=
 =?utf-8?B?RytWZThYdGJ0akp5SmlrVFgwUEFvTmhxd2xqSktVVEpxc3pQNVlqRng3bk53?=
 =?utf-8?B?RjBFZEZuWmw4VHArZFh5SWY3SCtxTXRBejIyRkpUajlPdTZuU1l6cXZCM3J4?=
 =?utf-8?B?aWJzRy9DbnRkVjZoSXd0aFkrS2VUK3ZKeXRBMW1uOHU3TFJVWjA2Mzc2T3dU?=
 =?utf-8?B?dWQ4Mkd1a3lDTVBlNkM2QkVhblU0ZXNNbGtKOFVMSVRuTENmYTg3ODJsaGw4?=
 =?utf-8?B?NmtkT215TVhRbGZLUlFvWDVUclloTllFeDMzSnVqNTVjaDF3NC95dlY4Y2lK?=
 =?utf-8?B?MVNkRTZSeWpIdGxtVHczVTN6MVVzSjFJR3laZ1loMjh4aWRhUzlPcCs1UTQ2?=
 =?utf-8?B?SkdXdFJLaFZCb295ZE5ibWRUQ3NNaXJBTDNScmhjbU5IL2JjU0J6b0VKT2JF?=
 =?utf-8?B?ZXZtd2o3d0NGaHJHZW5GdjRYYUtvMEduYWkrM3E0bmthMDQ4WHYrQnowQk03?=
 =?utf-8?B?MWVIWEVoVXpMclRlSGNGYzFkMzNlSE9QVE82ZE1RbVZ4MC82dU5aN0s5Qnl5?=
 =?utf-8?B?SXpGWFhTK3dCNWZ0WXFQSnNoN1oxSWRnNjlZUSszRUdEMHpDV0VHL3EwelZi?=
 =?utf-8?B?c3BTRVNsZnBhdlVpcDh6eU5JSWgxdTRndDFxYlVTOXFTNExCdHoyNUhEc2cy?=
 =?utf-8?B?bjRBR3ZTZ2JOSEtyaCt3ZUFDd1lMRVNhVUx5Rm1Qa1BvcXhsUFppOU9RbUxO?=
 =?utf-8?B?UDV6RWdHcUtmcERVRWxvbW9OVFR6RmF2cERSb3k4QkRYSC84Vm5zRFdIZjgz?=
 =?utf-8?B?UXh5TE94cXBUNE0vRzIzQ0dtcmg5d3p3Y1BkWVhLRk42WHpOYnlWNDBLalJC?=
 =?utf-8?B?V3lvL2t3V0R4UVZLWjFMdnR0RVZwcHZBTWw0Ty9Zdk5mMmJ0QUNXOHdwbC8x?=
 =?utf-8?B?RUV5YmxSS21kbE51Z1AvUHBHSng0d3VLT2wySE9lSmlpeG1qKzhPMEN5K21t?=
 =?utf-8?Q?Drm/2aTnHt1ln/zFfBvAmDXAt6yWsBaO9EM0w1aZMnJV?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6626fadf-c045-4a10-a898-08dbcf7468f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 00:51:48.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUDkNrVxi0T4RqahaesRLoKkXbTnSP/evWy6W0IlrwKtReXilKAqygV/rRdwBXENKC9BIJIgLCdj7lHjK8L01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+IERvIHlvdSBoYXZlIG11bHRpcGxlICJhZGFwdGVycyIgaW4gb25lIGliL2V0aCBkZXZpY2U/
DQo+ID4gSWYgeWVzLCBhdCBsZWFzdCBmb3IgSUIsIGl0IHdpbGwgYmUgdmVyeSB1bmV4cGVjdGVk
IHRvIHNlZS4NCj4gPg0KPiBBZGFwdGVyIGlzIElCIHNwZWNpZmljIGFuZCBvbmUgcGVyIFZGL3Bj
aWUgZGV2aWNlLiBJdCdzIHRoZSBoYW5kbGUgdGhhdCBpcyBwYXNzZWQNCj4gYmV0d2VlbiB0aGUg
bWFuYWdlbWVudCBhbmQgVk0gZm9yIGJvb2sga2VlcGluZy4NCg0KSSB0aGluayB0aGVyZSBhcmUg
c29tZSBjb25mdXNpb25zIG9uIHRoZSBkZXZpY2UuDQoNClRoZXJlIGlzIG9uZSBkZXZpY2UsIHRo
YXQgc3VwcG9ydHMgYm90aCBFdGhlcm5ldCBhbmQgUkRNQSh0aHJvdWdoIFJvQ0UpLg0KDQpPbiB0
aGUgZGV2aWNlLCBSb0NFIGNhbid0IGZ1bmN0aW9uIHdpdGhvdXQgRXRoZXJuZXQuIEluIHRoZSBM
aW51eCwgdGhlIFJETUEgZGV2aWNlIGlzIG1vZGVsZWQgYXMgYXV4aWxpYXJ5IGRldmljZSB0byBl
dGhlcm5ldCBkZXZpY2UuDQoNClRoZSBwaHlzaWNhbCBkZXZpY2UgZXhwb3NlcyBib3RoIEV0aGVy
bmV0IGFuZCBSRE1BIG1hbmFnZW1lbnQgaW50ZXJmYWNlcyAoYXMgYWRhcHRlcnMpIHRvIHRoZSBj
bGllbnQgKExpbnV4IGtlcm5lbCkuIFdoZW4gdGhlIE1BTkEgUkRNQSBkcml2ZXIgd2FzIGZpcnN0
IGludHJvZHVjZWQsIFJBVyBRUCB3YXMgc3VwcG9ydGVkLiBUaGVyZSB3YXMgbm8gbmVlZCB0byBj
b25uZWN0IHRvIHRoZSBSRE1BIG1hbmFnZW1lbnQgaW50ZXJmYWNlLiBNYW55IGRldmljZSBoYXJk
d2FyZSBSRE1BIGNhcGFiaWxpdGllcyB3ZXJlIGhhcmRjb2RlZCBpbiB0aGUgZHJpdmVyIGF0IHRo
ZSB0aW1lLiAoVGhlcmUgd2VyZSBzb21lIHJldmlld2VycyBxdWVzdGlvbmluZyB0aGlzIGF0IHRo
ZSB0aW1lKS4NCg0KV2l0aCB0aGlzIHBhdGNoc2V0LCB3ZSBhcmUgY29ubmVjdGluZyB0byB0aGUg
UkRNQSBtYW5hZ2VtZW50IGludGVyZmFjZSBvbiB0aGUgZGV2aWNlLiBUaGlzIGlzIGZvciBhZGRy
ZXNzaW5nIHRoZSBwcmlvciBjb21tZW50cywgYW5kIGZvciBzdXBwb3J0aW5nIHVwY29taW5nIFJD
IFFQLg0KDQpUaGFua3MsDQoNCkxvbmcNCg0KDQo+ID4gV2h5IGRvIHlvdSBoYXZlIGNsaWVudCBh
bmQgZGV2aWNlIHdoZW4gdGhleSBhcmUgYmFzaWNhbGx5IHRoZSBzYW1lDQo+IG9iamVjdHM/DQo+
ID4NCj4gSSBhbSBub3Qgc3VyZSB3aGljaCBvbmVzIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHNwZWNp
ZmljYWxseSAsIGNhbiB5b3UgcGxlYXNlDQo+IGVsYWJvcmF0ZT8NCj4gDQo+ID4gPiBQbGVhc2Ug
bm90ZSB0aGF0IHRoZXNlIGFyZSB0ZXJtcyB1c2VkIGZvciBkaWZmZXJlbnQgcHVycG9zZXMgb24g
dGhlDQo+ID4gbWFuYWdlbWVudCBzaWRlLg0KPiA+DQo+ID4gV2UgYXJlIGRpc2N1c3NpbmcgUkRN
QSBzaWRlIG9mIHRoaXMgc2VyaWVzLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4NCj4gPiA+DQo+ID4g
PiA+IFRoYW5rcw0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBG
cm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDExLCAyMDIzIDc6MzMgQU0NCj4gPiA+ID4gPiA+IFRvOiBzaGFy
bWFhamF5QGxpbnV4b25oeXBlcnYuY29tDQo+ID4gPiA+ID4gPiBDYzogTG9uZyBMaSA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPiA+ID4gPiA+IDxqZ2dAemllcGUu
Y2E+OyBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgV2VpIExpdQ0KPiA+ID4gPiA+
ID4gPHdlaS5saXVAa2VybmVsLm9yZz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD47DQo+ID4gPiA+ID4gPiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraQ0KPiA+ID4gPiA+ID4gPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
IDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4LQ0KPiA+ID4gPiA+ID4gcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gPiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBamF5DQo+ID4g
PiA+ID4gPiBTaGFybWEgPHNoYXJtYWFqYXlAbWljcm9zb2Z0LmNvbT4NCj4gPiA+ID4gPiA+IFN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQYXRjaCB2NSAwLzVdIFJETUEvbWFuYV9pYg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IE9uIFRodSwgU2VwIDA3LCAyMDIzIGF0IDA5OjUyOjM0QU0gLTA3
MDAsDQo+ID4gPiA+ID4gPiBzaGFybWFhamF5QGxpbnV4b25oeXBlcnYuY29tDQo+ID4gPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRnJvbTogQWpheSBTaGFybWEgPHNoYXJtYWFqYXlAbWlj
cm9zb2Z0LmNvbT4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQ2hhbmdlIGZyb20gdjQ6
DQo+ID4gPiA+ID4gPiA+IFNlbmQgcXAgZmF0YWwgZXJyb3IgZXZlbnQgdG8gdGhlIGNvbnRleHQg
dGhhdCBjcmVhdGVkIHRoZSBxcC4NCj4gPiA+ID4gPiA+ID4gQWRkIGxvb2t1cCB0YWJsZSBmb3Ig
cXAuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEFqYXkgU2hhcm1hICg1KToNCj4gPiA+
ID4gPiA+ID4gICBSRE1BL21hbmFfaWIgOiBSZW5hbWUgYWxsIG1hbmFfaWJfZGV2IHR5cGUgdmFy
aWFibGVzIHRvDQo+ID4gbWliX2Rldg0KPiA+ID4gPiA+ID4gPiAgIFJETUEvbWFuYV9pYiA6IFJl
Z2lzdGVyIE1hbmEgSUIgIGRldmljZSB3aXRoIE1hbmFnZW1lbnQgU1cNCj4gPiA+ID4gPiA+ID4g
ICBSRE1BL21hbmFfaWIgOiBDcmVhdGUgYWRhcHRlciBhbmQgQWRkIGVycm9yIGVxDQo+ID4gPiA+
ID4gPiA+ICAgUkRNQS9tYW5hX2liIDogUXVlcnkgYWRhcHRlciBjYXBhYmlsaXRpZXMNCj4gPiA+
ID4gPiA+ID4gICBSRE1BL21hbmFfaWIgOiBTZW5kIGV2ZW50IHRvIHFwDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gSSBkaWRuJ3QgbG9vayB2ZXJ5IGRlZXAgaW50byB0aGUgc2VyaWVzIGFuZCBo
YXMgdGhyZWUgdmVyeQ0KPiA+ID4gPiA+ID4gaW5pdGlhbA0KPiA+IGNvbW1lbnRzLg0KPiA+ID4g
PiA+ID4gMS4gUGxlYXNlIGRvIGdpdCBsb2cgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvIGFu
ZCB1c2Ugc2FtZQ0KPiA+ID4gPiA+ID4gZm9ybWF0IGZvciBjb21taXQgbWVzc2FnZXMuDQo+ID4g
PiA+ID4gPiAyLiBEb24ndCBpbnZlbnQgeW91ciBvd24gaW5kZXgtdG8tcXAgcXVlcnkgbWVjaGFu
aXNtIGluIGxhc3QNCj4gPiA+ID4gPiA+IHBhdGNoIGFuZCB1c2UgeGFycmF5Lg0KPiA+ID4gPiA+
ID4gMy4gT25jZSB5b3UgZGVjaWRlZCB0byBleHBvcnQgbWFuYV9nZF9yZWdpc3Rlcl9kZXZpY2Us
IGl0DQo+ID4gPiA+ID4gPiBoaW50ZWQgbWUgdGhhdCBpdCBpcyB0aW1lIHRvIG1vdmUgdG8gYXV4
YnVzIGluZnJhc3RydWN0dXJlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoYW5rcw0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9ody9tYW5hL2NxLmMgICAgICAgICAgICAgICB8ICAxMiArLQ0KPiA+ID4gPiA+ID4gPiAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMgICAgICAgICAgIHwgIDgxICsrKy0tDQo+
ID4gPiA+ID4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWluLmMgICAgICAgICAg
ICAgfCAyODggKysrKysrKysrKysrKy0NCj4gLS0tLQ0KPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9p
bmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oICAgICAgICAgIHwgMTAyICsrKysrKy0NCj4gPiA+
ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMgICAgICAgICAgICAgICB8
ICA0MiArKy0NCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL3FwLmMg
ICAgICAgICAgICAgICB8ICA4NiArKystLS0NCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tYW5hL3dxLmMgICAgICAgICAgICAgICB8ICAyMSArLQ0KPiA+ID4gPiA+ID4gPiAg
Li4uL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9nZG1hX21haW4uYyAgIHwgMTUyICsrKysr
LS0tLQ0KPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEv
bWFuYV9lbi5jIHwgICAzICsNCj4gPiA+ID4gPiA+ID4gIGluY2x1ZGUvbmV0L21hbmEvZ2RtYS5o
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLQ0KPiA+ID4gPiA+ID4gPiAgMTAgZmlsZXMg
Y2hhbmdlZCwgNTQ1IGluc2VydGlvbnMoKyksIDI1OCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPiA+
DQo=


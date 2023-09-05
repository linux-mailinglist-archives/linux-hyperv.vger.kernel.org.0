Return-Path: <linux-hyperv+bounces-3-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3B792DB0
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6CA1C20960
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DCBDDD1;
	Tue,  5 Sep 2023 18:49:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3170DDD0
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 18:49:37 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C11B6;
	Tue,  5 Sep 2023 11:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBFJ1pgD4OWSajPHHTOgjIWBbedz6HD4Mf+6vpv7sXom5+n61R03UcwGHSpkK/2kr6zmsDemH9oJvp0VAPVby09WU7V3iIHSIYbAUKf7kmu6TQ4n7bh6XzEDWnjpHmbyq+P+zbdxPAtqRdUE03Bxn/AK7nEAgWtW9tcnkih5S7wAZVlRuiUfb6BkUNxO5MhIjcfAlKy6+PQ8aeA/N49Tt5KTUaA47k7i4MjsC/gUeLQKoS0gD/Ar/7igsuXLWNZfAYut06cBqcS32j+ZtCZ4aifJLTPm8gWyFMNNMs75oC5+In/AolkA2Ske1yNRIFBapvoLCM1dNCNtqzF6yeX/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCI0WfbuvHKtUqzzhyw7PbWonX5BdZUa2FvP7ayLfyU=;
 b=mAWmpQitbF4Z0eMzxwOs4CREY8iaIJTfupX60wPWJYdHX+59FKC7sp6hgrkrm52q3hDUg+0G97bmXQU2ox7gyyAelq2egNPLGJk/EsNNFkaqSj2pWQcxOr3+E/SIRH+JLkINynvoj1hXVP8G0mXa+xh6RUaspDstAEggdKoiGqq5ZhhMS3/e+nQSZzW1grwvUBxXrA2XdWOCPgZoOHD2zwePYIDOKmaXGA2FoA2nxS20+ck8szNSEzIjVILgDQlrH6lRsULb2eI8ZVGFCP2orFP5OUtY9Tfd0cFTQcBCCey3nONcop5SjRB2irL6F1KwpUduY3uzibegwQ0zRhoKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCI0WfbuvHKtUqzzhyw7PbWonX5BdZUa2FvP7ayLfyU=;
 b=UZefn8XcXTfrH9qCuKlUuFdt5tJOGFvWQm/ugMGM2s+Yyh9HqUrvvZaed15XaJiG2I6LttzgjxvASaw/TVo37nKLxPEKh2iwwB6hrIIuQTc9C9T/lQz9Y1F3BPQ+3OXQfgz0LQTU2TGq1K6ahCBgkic+iUpRaJtIeWCSWDhA4rE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB3335.namprd21.prod.outlook.com (2603:10b6:510:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Tue, 5 Sep
 2023 18:04:58 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6792.005; Tue, 5 Sep 2023
 18:04:58 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, jason <jason@zx2c4.com>,
	"Lutomirski, Andy" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, KY Srinivasan
	<kys@microsoft.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "Michael Kelley (LINUX)"
	<mikelley@microsoft.com>, "chu, jane" <jane.chu@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Luck, Tony" <tony.luck@intel.com>, "Christopherson,, Sean"
	<seanjc@google.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "brijesh.singh@amd.com"
	<brijesh.singh@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: vkuznets <vkuznets@redhat.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, Anthony Davis <andavis@redhat.com>, Mark Heslin
	<mheslin@redhat.com>
Subject: RE: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZzJ23VWbZscw9EEKPl7FjsLjo4LAMkcwAgAAbJcA=
Date: Tue, 5 Sep 2023 18:04:58 +0000
Message-ID:
 <SA1PR21MB133590EA3CF1A30FCE0FF203BFE8A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811214826.9609-1-decui@microsoft.com>
	 <20230811214826.9609-3-decui@microsoft.com>
 <e8b1b0b5f32115c0ef8f1aeb0b805c4d9a953b31.camel@intel.com>
In-Reply-To: <e8b1b0b5f32115c0ef8f1aeb0b805c4d9a953b31.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=048f738f-4b93-4394-90e3-3e96130d38e9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-05T18:02:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB3335:EE_
x-ms-office365-filtering-correlation-id: 5adc1053-c11b-43b1-ff81-08dbae3a9e24
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c1Sg9y/GJIL1GXmA/5H1LRtYkkouErXcSS0WXGYhsdVoZbnXykv48oqY2/HCzDt5wK1R9bfqoos9vDNoURqRHf2YcHrlwpYbsB5ATjfr80Jrlfv8SMnhUXM6lqZxgU4OhgKeozR6evgZ8+g7+bXBjVxW3Jqebj2ZaKr5SzD8ceEh7I5Cx61ewz0lBkriFGvD2mw90OjYMXi0rSkx6iwr7QBOfdC+XbRdYLfPIvgTtmbogtl4N3vSRciu0x3L4NzqGfCwT8H3T6W3mgxTM7VEB/GSgrEDBogFsZW+ph6vvWlcgPxikJfAT4rv6/w+HDj+EZLdiZlOsXAwszsj/vDQ2y5h6RkB0gi1SyLjmWFnnlK5RR0M4kF2SXamltnbJ6z5ca2TQ3JgM0Wwcgow0GSq3MDUn18Uh7ffhW26Hy7+drtL9FuPIK+9wtjeuXuQZw3PfO8d40CDbUTyqBTP13mHeEgO3WS5lkeq9q0an9LHuKcpwe+alQiMC2UIYZ9dtzgCYcQ9Pn4xQER1+s4OVJhcAx6Cn27C8iJsjWD4WwGKnMS8sNFOpDoMIj8vBZP2LYB3H59N3PT/l15KImzfasY/ol8qd2bfGNvSzpXzgXY8GRVRIwa8Z4eQ2xvlQgxc8YSnHcZnv30OjhfbF1y1DI9TJB+cIRFUQ82YxRRFX3dTaRX0O2APsKkwbhwLKjuvOtin
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(921005)(82950400001)(122000001)(9686003)(71200400001)(6506007)(7696005)(82960400001)(33656002)(38070700005)(55016003)(38100700002)(86362001)(2906002)(83380400001)(10290500003)(478600001)(110136005)(76116006)(52536014)(66946007)(8676002)(8936002)(5660300002)(4326008)(316002)(41300700001)(7416002)(54906003)(66556008)(66476007)(66446008)(64756008)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bERqVzFEdHlML0htdXlieVlzbUJXamE2MTdXaHdZZXljd3RMa3RqM0RIZUtH?=
 =?utf-8?B?Q0FiUG5WRWJvY0l6aWlWWm56NXFiT1VZcThvNHUwSmoxbHVqWGhYZWZSc3ZM?=
 =?utf-8?B?L2xWeGs1MzVoNkNGNXNoRVg0dXcyOFNxbEZuWUlQeVAxVnZZQThreXFqSnF6?=
 =?utf-8?B?aDBaeFM1UWptSVkzajErMVVGdDN5NXhieEExTURZcXFHTkZXOGwxelVWWlhX?=
 =?utf-8?B?S1RPZmk3T2FxZTRLZVY0My93dWh2RkJ6NVVqd21RcDgxUU1MUDdzZzRpQzR2?=
 =?utf-8?B?Skp0QnlXRlE0R1doRXVWQXBacXBESzFjRFM0RW1CMEhLOWNFZ0x0KzBqYkg0?=
 =?utf-8?B?WTlmL3YzbkhXVXF6ZVhyelFFNWorNjJ1aU02VlhrQU5kQzNweUx3OXdhWVJk?=
 =?utf-8?B?NGZqVzdTMG9RaDVJcXBpWUpJb01rQythOFRSaHNJN0dlMTRiN2dMZWZQcEQv?=
 =?utf-8?B?cTdvdkZXREtkV3VMclJPdGJmVFRrOVdHTXM2ck9TYUh5akpxODI4RzRtbi9K?=
 =?utf-8?B?L0tkTlhLTGw4OXIyUGJac2F0Q1QybmxVYWM1bkJ5QjZ2cnBCV2plRk1uYnho?=
 =?utf-8?B?dzFSMVRoYmpqN1I3WVp1NmsyTDhyU2FSRzlFaTMxcWpnajdtMWcybit2Z0hM?=
 =?utf-8?B?MHhWeVB0eHBCNGZ4OTV4UXJTY1BhTE1abXJXSDlNaEVHenV6TnJOK0dNSFpJ?=
 =?utf-8?B?am5pZ1I1WGpuczN5cXRuTG8vNVdPdjMzV3AwVzJhdWxYWVhseUw4eE53blo4?=
 =?utf-8?B?U2pTVGsxRERzUFhWZFNNUnFhOTZzL0s5VmFtRFZ5ci9USE9MeUtpNUZJcVZK?=
 =?utf-8?B?RDBMYzVRT0FUSDRQSTdacG4xUFlaUEV5dStUYWJIYy9IUDlMcFFKdnoxcGdJ?=
 =?utf-8?B?NkRMc1VDdW40SzNnVlVOZ0E1MElQcVdtck1Tbk1wR1NjMU1hYmtjNDErTWxB?=
 =?utf-8?B?ZnhxSXZyZmlvWU5ucTBXSUhLZkZmdHdRY05NTmFZa09KVGF2U0ppSytROElY?=
 =?utf-8?B?L1o5bWZERE9rSjdBWERVaENZeEdEQzUrcnlTbmQ1MVZQSHQ4alhGbXgySW9K?=
 =?utf-8?B?L3RzR3Y1SFlmZGpxaFdtMmt0bjJYWWFtajE3QVlOWVU4eFlEcUtOZzhVVlFQ?=
 =?utf-8?B?amUzYXZmV05EUGdNVTUwdTZuOTN4dFBqLzZWSE50Vk1xV001S0hCbTZwVzU4?=
 =?utf-8?B?NlU3NkRXTHZnTnB4czZjZnMwM0g5bVdqL21sM0IzcXNpbW9ZWUtKSU9CUnRy?=
 =?utf-8?B?R0txWjhoZFhjeXF1ZUkvNHVFSlFROGROQnVDaHFOeDE1YmlYVFRTVzdyZEF2?=
 =?utf-8?B?ZGQ4cEhtYTYrMDFEYXpSOXN5UzVMR2hOT1hBQjRTS3BLWC85WVRRTzdxN24x?=
 =?utf-8?B?RGlOdHVYakkyUTZBLzNnamRPNFQySTc4ZzNQck1LM0RGMmVDcnNsVXhTK3Ru?=
 =?utf-8?B?d3l2dXFxYS9KdHQ0R2cwOUlPdjE0a2JrSHN1ZS95d0hMa2hyWC9Gb2tLWUFO?=
 =?utf-8?B?Y3IwbERkWExmUDZxZE43elRuVnN0THI3SFdZWGZ4ZDNHZUFoTWxWYjBEelh3?=
 =?utf-8?B?SWFPWm93WU5JSHRtci9mTm5wTzd0MTAxZk5jTGVKOGhzb3pzRzNlQ0t1bFdu?=
 =?utf-8?B?SUREYzVJeWhWdUhianBzVHVlZTlJb3RKRG9yQVJhaVhaenZIT0pZZ3lhMDc1?=
 =?utf-8?B?aXhyTE5POEpmTEZEbVRXcmF5YWRIUXkyMk1hTWIzb1VXbUNwR0x6N1NuQ2Fm?=
 =?utf-8?B?c2lPUTlHbG9tR01pbWlrUTR2T1dUaFNkV1ppeEJpL2JOMWVJd3ZxWVFNU05m?=
 =?utf-8?B?M0lVY2Y1RlpxZElsZFM4SkJrek9MQ21FZVkzTHIvQXl1UzJHaGVSTVNBNHlr?=
 =?utf-8?B?YmltdkloQThBYnNVVVNpejFialFzYllvaWd2UXN0K3cvWXM1WEZpNWxHQzQr?=
 =?utf-8?B?RTB6SHo1STFQRXo2YzlzTFZPdVB2TEhIdXNGdEt3Tk91VmdHNTB3QStRbzlk?=
 =?utf-8?B?RHpyWlRvSkFWZ3NhaDBiSTFJVVhHNTErSzRBMTVGZytNWGdlR2RiM3lHSDlH?=
 =?utf-8?B?NndFZFVwcmVyOHdPMGd6eGlmMFNnY1pTVUNpYWJOUHNtWEw4UXl2b0crTHhF?=
 =?utf-8?B?bXRaUzFEU3VPWWNGLzlVZTZ0Q1NNeW1pVWV3SVNDb09QL3l1WlluL3ZLOWJj?=
 =?utf-8?Q?QMyPsqKo1K3aumn7ybFA7THWnujH91Ybiym0Eqjtf7rd?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adc1053-c11b-43b1-ff81-08dbae3a9e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 18:04:58.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Kpq/wxerpRlyQxN9Jr0+MF+9MhvrS+8Dsb0ODvKp1FDh8RH4XsUmM4FOv0pZT/RuaF873a5clgkJ+0/3A7KgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiBGcm9tOiBFZGdlY29tYmUsIFJpY2sgUCA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciA1LCAyMDIzIDk6MjUgQU0NCj4gWy4uLl0NCj4gT24g
RnJpLCAyMDIzLTA4LTExIGF0IDE0OjQ4IC0wNzAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IFdo
ZW4gYSBURFggZ3Vlc3QgcnVucyBvbiBIeXBlci1WLCB0aGUgaHZfbmV0dnNjIGRyaXZlcidzDQo+
ID4gbmV0dnNjX2luaXRfYnVmKCkNCj4gPiBhbGxvY2F0ZXMgYnVmZmVycyB1c2luZyB2emFsbG9j
KCksIGFuZCBuZWVkcyB0byBzaGFyZSB0aGUgYnVmZmVycw0KPiA+IHdpdGggdGhlDQo+ID4gaG9z
dCBPUyBieSBjYWxsaW5nIHNldF9tZW1vcnlfZGVjcnlwdGVkKCksIHdoaWNoIGlzIG5vdCB3b3Jr
aW5nIGZvcg0KPiA+IHZtYWxsb2MoKSB5ZXQuIEFkZCB0aGUgc3VwcG9ydCBieSBoYW5kbGluZyB0
aGUgcGFnZXMgb25lIGJ5IG9uZS4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuDQo+ID4gPHNh
dGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+IMKgYXJj
aC94ODYvY29jby90ZHgvdGR4LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJl
QGludGVsLmNvbT4NClRoYW5rcyENCg0KPiBPbmx5IHNtYWxsIGNvbW1lbnQsIGl0IGlzIHBvc3Np
YmxlIHRvIGhhdmUgaHVnZSB2bWFsbG9jJ3Mgbm93LCB3aGljaA0KPiB3b3VsZCBtZWFuIHRoaXMg
d291bGQgZG8gNTEyIFREVk1DQUxMX01BUF9HUEEgY2FsbHMgaW5zdGVhZCBvZiAxIHdoZW4NCj4g
ZW5jb3VudGVyaW5nIGEgaHVnZSB2bWFsbG9jIG1hcHBpbmcuIElmIHRoaXMgdXNlZCBsb29rdXBf
YWRkcmVzcygpDQo+IGRpcmVjdGx5IGluc3RlYWQgb2Ygc2xvd192aXJ0X3RvX3BoeXMoKSwgaXQg
Y291bGQgY2F0Y2ggdGhpcyBjYXNlLiBJDQo+IGRvbid0IHRoaW5rIHRoZXJlIGFyZSBhbnkgY2Fz
ZXMgb2YgaHVnZSB2bWFsbG9jcyB0b2RheSB0aGF0IHdvdWxkIGdldA0KPiBwYXNzZWQgaW50byBz
ZXRfbWVtb3J5X2VuL2RlY3J5cHRlZCgpLCBzbyB3b3VsZCBvbmx5IGJlIGZ1dHVyZQ0KPiBwcm9v
ZmluZy4NClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIFNvIEkgdGhpbmsgbGV0J3Mga2VlcCB0
aGUgY29kZSBhcy1pcyBmb3IgDQpzaW1wbGljaXR5LiBXZSBjYW4gZW5oYW5jZSB0aGUgY29kZSBp
biBmdXR1cmUgd2hlbiBpdCdzIG5lY2Vzc2FyeS4NCg==


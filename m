Return-Path: <linux-hyperv+bounces-545-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8987CCB32
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B31C20A64
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175044487;
	Tue, 17 Oct 2023 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NaYeDYUO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A72D7AB;
	Tue, 17 Oct 2023 18:51:38 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83EF0;
	Tue, 17 Oct 2023 11:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9d/+HT8XKB1goiJqN4tLNbI9tkHyoK1ludKxm2K/X/3SVl9xyZfUwom2zbVvMgR22/I/+HDEyagr4iO95GZUf7c7aqTjBOIkCRcMTpMqUqQV+j5/q5b7lM1c806q2EAinHn8WtUVw0M9sMQJ766OQPBTvpZSIk6+TGGWiCjoRw1fD/DbaqLpeqBAisFaxSADOSExUeb98qUis5rVNhRx73kjsDlszWhq6pn+cPUTcpOSlwWLOY6xEwjBnGNICfiv9/I777nsjkYwnru/FlSSnFPSJ50iVXnx64XLZ4130/2dXn4zzH7xT+ULUEfE+qkLv5jIYbiNsiI5vWYEU4hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fn7dhcFmu+XuMJQvKhruZ09HbnM8STBizCbZIfSWz0=;
 b=ZKp1N8baOIo0EB7aTq7dhXB9Sxu6/sv9WgFw0R2awbfmgoLEOIDIklPJXBOBkLvtZ63Bjip1gD8BP4hBNoTo8SmTnJGdm9Mvq9JF3QJjcDOeYxFsXBS1PHdFQJF0co/56caT9GLXFQHA57S5QFjCbsJtsKifNNHIbMa0AqhvJEsQG4EwRMukLIf7cMsiIWMcoowgxP+CPC4FFfFti6N2eX57LOic7nsp2tJmMqmUPwD6YqxvzIYyjylnVgiVySFjdkb641uLE0UhnK0iRot0OU+LzLzkBvYvVH6ulopn4QJXSv5pDJvLziWIsYAIgGKuezOPVr44GJOVp82F3aQTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fn7dhcFmu+XuMJQvKhruZ09HbnM8STBizCbZIfSWz0=;
 b=NaYeDYUOxLjGtLjfyUkOkIj8tcOq5II5GxwwRDEr/1RJudSb1WkP8MD6QE/PCLdbaBR7dg/tWVo7/XAlRD/WQs3wBZqMLq+8q1nwd32zyTSkCaQlhXw+vT67aFuap98tZ7UHvQOWwb4rx8ST1g/H9KremPkyA4xs0ow5S123oqs=
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by PH7PR21MB3239.namprd21.prod.outlook.com (2603:10b6:510:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3; Tue, 17 Oct
 2023 18:51:33 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3%4]) with mapi id 15.20.6933.004; Tue, 17 Oct 2023
 18:51:33 +0000
From: Ajay Sharma <sharmaajay@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>, Long Li
	<longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>
Subject: RE: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Topic: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Index: AQHZ5KwOjzbv5vFcSU2j0jIgYOlpn7AV+Q7QgApR9oCALOdL8IAAoPKAgAC38ZA=
Date: Tue, 17 Oct 2023 18:51:33 +0000
Message-ID:
 <MN0PR21MB360682AE32CBD7B26DE435BDD6D6A@MN0PR21MB3606.namprd21.prod.outlook.com>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
 <20230918082903.GC13757@unreal>
 <MN0PR21MB3606BE5B57AF1FEE85915F3AD6D7A@MN0PR21MB3606.namprd21.prod.outlook.com>
 <20231017074821.GB5392@unreal>
In-Reply-To: <20231017074821.GB5392@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=967a5d7d-5e48-45b9-9739-1af9aba6fc91;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-17T18:46:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3606:EE_|PH7PR21MB3239:EE_
x-ms-office365-filtering-correlation-id: c846c9b1-3ab8-419d-ec41-08dbcf42150a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /OxQpSIUHZ6vOtVEF07U1XVJ34kDA/IbqBo1I82oBcnqw/jNdccF4P6v9xjr4EBmS2N+TAKxeBGMpH6FMbAb2T1YvduwfiIk1BfQm45Y5+CdxtF1sXVB+/GDSxhp1GMdVwO3HbkkOXtN/WfLqgB9iT7iE5cM+he75ii8rWcCPmU3rc+Uouj5ujnTx/tAtDX0sO73n7ESSctw+GwiHNm7Ur8KJkUG2trHsQ9p2yHv2OKEHjuIw2b9ewhpkjgt1+DS353WPoKCXxPZUhIpfHO31klPQNXMOItr3aSvBdGLoLaPiDevEDIDqOm/+c63/RKBee/c5fJbhd6RwG12L8l9LMDZ4E5JUIZlLpnlUleFe5ihNUNW8cj2dR44FRJ23CN5OEyAws9MxGAs+uOHFWALbvjwdd6HRxsUm+uDvu9ke6M3Ygj6qOwXr3NOCGzOEYefeIX+13YrUFNGi8IVdF0ewECq+stw/Zrvwf2SAtMx5GWzfrp8GeQT3y0FimWFflu97t4BAkDC6hiTc+MHquJn1p5e0ihzEmK+24Rzc/ogRMYLkinKXovzMojjg711oe8GsoPo6nvB8sHE9tuvNyHq1aUAv3ci4c33W3LhVWC1mTNVQLUIIp1479oy0ilgzmxjfXqlm7W1DV3ONvniL+sW9wprcuohTDQsO3ql8DdnJBQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(1700900015)(54906003)(71200400001)(41300700001)(5660300002)(83380400001)(55016003)(478600001)(9686003)(122000001)(2906002)(7416002)(107886003)(26005)(82960400001)(82950400001)(316002)(66446008)(66476007)(38070700005)(38100700002)(8990500004)(6916009)(10290500003)(52536014)(64756008)(4326008)(7696005)(6506007)(53546011)(8676002)(8936002)(76116006)(66946007)(86362001)(33656002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1FEaGtZY1RvMXNnNWFrRDM0YytOZzNOTXhKNzVhQUd4TWpiZUxkSTN0RWVu?=
 =?utf-8?B?RVdNYTBzK0hlQnRxeEFFUXdtUDBtYnRyV0o1akRaMmxOc21yMmREcHpQU1Z5?=
 =?utf-8?B?WlFSMk9hSXNaengrdnVhZGJ5RVNaQU44bnREb3NOcEw1aFZsOXVQU1cvVSs0?=
 =?utf-8?B?bHUvQXB1OXVCVXVhV1NwUDU4bVNYNSs2ZFA2NzI3NEtvQklObmFqL0pwbmV0?=
 =?utf-8?B?aTZmUmFMMHpxckE1ZTVIWTdFSmhKN2VDZ292TnhOUXBxSUNzZi9BTHNJR0Zi?=
 =?utf-8?B?eTVYOWVvWmx0Si9SMFB4ei95M2JHcVdGajZHOHBPbTM0L2RmWTlXNURIV0ph?=
 =?utf-8?B?bUQyeENrRDlxamJqZDhtckpFTUNGdFZyQVdHRVpQNVZKRExYcUxvRHZ4MFNT?=
 =?utf-8?B?ZDBBSnkwbjE0eXhjdzRqanZNVk55QzdjWk1iT0VSYkhMV2JEL1AvcnlTekQ0?=
 =?utf-8?B?UFA3SGVHeXBkc2pLbWlUWWs3RzlMZGdGQ3hXZzlhK0Y1b1V0dzgrZExHNUFh?=
 =?utf-8?B?MkxHTGcvWUZPWXJzenZERC8yNDFtYzdUdlV5cTByT2svYUtPQlFHYTBTV3lK?=
 =?utf-8?B?cnFJQTBtN2psRWFMSFJzbjZSRmYrYldwY1JackFEWit1VnJDcHJlNVpKV3A0?=
 =?utf-8?B?SVdGR203MkpiSHFUMlp5NzZEcUJCQTNjSXQ3NUN6cTAxaSt4cm9iM3MzTGor?=
 =?utf-8?B?b3gvNnBiQXAwSjY4bGdlbnVFbW5DS2xEYVpZS2pUWHc3RzliUnZQempFemhQ?=
 =?utf-8?B?WVpFRzdncWNBeERZRERMUDYzNUE5QkVZUEE3aDQ5dm9BYUZ0ZExtYkd2TlpV?=
 =?utf-8?B?RDROYUd5N1ZRSU5MNUtHZUxqZ2NRMWRKMFliT2prZFF2SVh1ZVQzZWY1Qks1?=
 =?utf-8?B?dkYrQnNELy9ZSGRReW5iL1hBSUYxSWFSUDVVcGRQM0tpNi8xSFN5SzNscDFF?=
 =?utf-8?B?UnZNTnJVMUVPeFRBUk5zN2NnTkVuTmVDVDBBTEwrOTlldHpPREd0Y1RUeUZN?=
 =?utf-8?B?Q0tvR3g0eVowd05NM25qVWJVd3p6a0lHaUhLaFNkNUxwcHdrbFNXUmJhb0N5?=
 =?utf-8?B?VlJQd25hRG9LS2ZndzVpV0VLK1Zja2gwSXpoQ0hQQVA0K2Q3V2RuTmdrSGdL?=
 =?utf-8?B?RXgwcFdwNklZcGtKRjV4bzFEU3k2SEQxRWF6NmIyRTYxUnVlM0pCcW1FMlov?=
 =?utf-8?B?N0hqUGw1Q2JHV3F3MGVyTXZLUE1qNW13b2ZIaHc3d25HL1RFMmYwNVlHc1Mz?=
 =?utf-8?B?aUxNZ2dNSnNmbUVxUXF4RzVHb2xxSStSTWNVUmxTQ3dXaXRyWCtLZ1FKTlhL?=
 =?utf-8?B?R0FnYkJyN2tXYUZNYmMyb1g2MU1CNEpaZjFJbEFCYm1Qd2gvK2tXVDVFQ0hT?=
 =?utf-8?B?M0ZSczRNNm9wM2ZUeTJyK3ovclZLS3BBWWEwSTQwc0lqc0R5alh3Z2J6QW44?=
 =?utf-8?B?eHRvWi9WVmNqNFV5SXBCeVB5aGo4ZHB4d3FjV3VBRjJuby9uMjhPY3lYcHds?=
 =?utf-8?B?ZG0rQ0lhdGFINmtIdHd3V0NmYlQyWFNXQ3lPcW41aW4rU1dxYmF6WlFsY0l5?=
 =?utf-8?B?RzNxU2gydXplWlZwcmpScmUvRjdHQkYvNVhob2NSQmJwVFpXNmtGVWl2YXZK?=
 =?utf-8?B?WGJxYllVQ1Q2K2hvbDFzWVF1UGJRZ3lVanZkSzFhSThVZ2xRd3RzNExlSFpK?=
 =?utf-8?B?Z0VaV2ZKelJUNkR6cFB0QWtRV2o0bG94Y28yYitXNHVKUlFvcHJTU3ZYd3Fn?=
 =?utf-8?B?NElNamVOdnZTRHBaSGpaWDdpZ2NaUVJFZDA3eGVhdmZYUWJBZ1JhMGNjNmdB?=
 =?utf-8?B?SzBRQ3d1WXIrdlR2SUhaMFlodTJBaG9JSFdhV2lBYWp4SExxaURDbDN2RWR2?=
 =?utf-8?B?K0c0VS93SDhTSllPNlB1dmJxc2dCUld5VVVXRGk5citqdTdNckJ1MzR6YnU1?=
 =?utf-8?B?L2xic1pTZlJoT2haWVZ3eEx1NWJCRzZyY3JMT2tNVzlTWHRmUmhhMTRZRWla?=
 =?utf-8?B?dVlvRENHbmVtYlIrbUlKSXQzOE5UZ2JobXBRaG1HRUJZWitwUWJKNTVETmhM?=
 =?utf-8?Q?0KhXqo?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c846c9b1-3ab8-419d-ec41-08dbcf42150a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 18:51:33.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKU4eOCyWjITy+0D5bQWwgzs/HqbSTU5YkaFVkIsMZTaZ62gXuPxojiDagHL4gDpeabJ4mFPJSZSzeEQjSMgl3b6BIEmDfgfzJjZX0wdppI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTcsIDIwMjMgMTI6
NDggQU0NCj4gVG86IEFqYXkgU2hhcm1hIDxzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+DQo+IENj
OiBzaGFybWFhamF5QGxpbnV4b25oeXBlcnYuY29tOyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0
LmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT47IFdlaSBMaXUNCj4gPHdlaS5saXVAa2VybmVsLm9yZz47IERhdmlk
IFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6
ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBB
YmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0g
UmU6IFtQYXRjaCB2NSAwLzVdIFJETUEvbWFuYV9pYg0KPiANCj4gT24gTW9uLCBPY3QgMTYsIDIw
MjMgYXQgMTA6MTU6MThQTSArMDAwMCwgQWpheSBTaGFybWEgd3JvdGU6DQo+ID4gSSBoYXZlIHNl
bnQgdjcgcGF0Y2ggc2VyaWVzIHdpdGggdGhlIHNwYWNlIHJlbW92ZWQNCj4gPg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMjMgMToy
OSBBTQ0KPiA+ID4gVG86IEFqYXkgU2hhcm1hIDxzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+DQo+
ID4gPiBDYzogc2hhcm1hYWpheUBsaW51eG9uaHlwZXJ2LmNvbTsgTG9uZyBMaSA8bG9uZ2xpQG1p
Y3Jvc29mdC5jb20+Ow0KPiA+ID4gSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBEZXh1
YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsNCj4gPiA+IFdlaSBMaXUgPHdlaS5saXVAa2Vy
bmVsLm9yZz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+ID4gPiBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraQ0KPiA+ID4g
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47DQo+ID4g
PiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgtIGh5cGVydkB2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4gPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BhdGNoIHY1IDAvNV0g
UkRNQS9tYW5hX2liDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgMDY6NTc6
MjFQTSArMDAwMCwgQWpheSBTaGFybWEgd3JvdGU6DQo+ID4gPiA+IEkgaGF2ZSB1cGRhdGVkIHRo
ZSBsYXN0IHBhdGNoIHRvIHVzZSB4YXJyYXksIHdpbGwgcG9zdCB0aGUgdXBkYXRlDQo+ID4gPiA+
IHBhdGNoLiBXZQ0KPiA+ID4gY3VycmVudGx5IHVzZSBhdXggYnVzIGZvciBpYiBkZXZpY2UuIEdk
X3JlZ2lzdGVyX2RldmljZSBpcyBmaXJtd2FyZQ0KPiA+ID4gc3BlY2lmaWMuIEFsbCB0aGUgcGF0
Y2hlcyB1c2UgUkRNQS9tYW5hX2liIGZvcm1hdCB3aGljaCBpcyBhbGlnbmVkDQo+ID4gPiB3aXRo
IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hLyAuDQo+ID4gPg0KPiA+ID4g4p6cICBrZXJuZWwg
Z2l0Oih3aXAvbGVvbi1mb3ItcmMpIGdpdCBsIC0tbm8tbWVyZ2VzDQo+ID4gPiBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWFuYS8NCj4gPiA+IDIxNDUzMjg1MTVjOCBSRE1BL21hbmFfaWI6IFVzZSB2
MiB2ZXJzaW9uIG9mIGNmZ19yeF9zdGVlcl9yZXEgdG8NCj4gPiA+IGVuYWJsZSBSWCBjb2FsZXNj
aW5nDQo+ID4gPiA4OWQ0MmI4Yzg1YjQgUkRNQS9tYW5hX2liOiBGaXggYSBidWcgd2hlbiB0aGUg
UEYgaW5kaWNhdGVzIG1vcmUNCj4gPiA+IGVudHJpZXMgZm9yIHJlZ2lzdGVyaW5nIG1lbW9yeSBv
biBmaXJzdCBwYWNrZXQNCj4gPiA+IDU2M2NhMGU5ZWFiOCBSRE1BL21hbmFfaWI6IFByZXZlbnQg
YXJyYXkgdW5kZXJmbG93IGluDQo+ID4gPiBtYW5hX2liX2NyZWF0ZV9xcF9yYXcoKQ0KPiA+ID4g
MzU3NGNmZGNhMjg1IFJETUEvbWFuYTogUmVtb3ZlIHJlZGVmaW5pdGlvbiBvZiBiYXNpYyB1NjQg
dHlwZQ0KPiA+ID4gMDI2NmExNzc2MzFkIFJETUEvbWFuYV9pYjogQWRkIGEgZHJpdmVyIGZvciBN
aWNyb3NvZnQgQXp1cmUgTmV0d29yaw0KPiA+ID4gQWRhcHRlcg0KPiA+ID4NCj4gPiA+IEl0IGlz
IGRpZmZlcmVudCBmb3JtYXQgZnJvbSBwcmVzZW50ZWQgaGVyZS4gWW91IGFkZGVkIGV4dHJhIHNw
YWNlIGJlZm9yZSAiOiINCj4gPiA+IGFuZCB0aGVyZSBpcyBkb3VibGUgc3BhY2UgaW4gb25lIG9m
IHRoZSB0aXRsZXMuDQo+ID4gPg0KPiA+IEkgaGF2ZSByZW1vdmVkIHRoZSBzcGFjZQ0KPiA+DQo+
ID4gPiBSZWdhcmRpbmcgYXV4LCBJIHNlZSBpdCwgYnV0IHdoYXQgY29uZnVzZXMgbWUgaXMgcHJv
bGlmZXJhdGlvbiBvZg0KPiA+ID4gdGVybXMgYW5kIHZhcmlvdXMgY2FsbHM6IGRldmljZSwgY2xp
ZW50LCBhZGFwdGVyLiBNeSBleHBlY3RhdGlvbiBpcw0KPiA+ID4gdG8gc2VlIG1vcmUgdW5pZm9y
bSBtZXRob2RvbG9neSB3aGVyZSBJQiBpcyByZXByZXNlbnRlZCBhcyBkZXZpY2UuDQo+ID4gPg0K
PiA+DQo+ID4gVGhlIGFkYXB0ZXIgaXMgYSBzb2Z0d2FyZSBjb25zdHJ1Y3QuIEl0IGlzIHVzZWQg
YXMgYSBjb250YWluZXIgZm9yIHJlc291cmNlcy4NCj4gPiBDbGllbnQgaXMgdXNlZCB0byBkaXN0
aW5ndWlzaCBiZXR3ZWVuIGV0aCBhbmQgaWIuDQo+IA0KPiBEbyB5b3UgaGF2ZSBtdWx0aXBsZSAi
YWRhcHRlcnMiIGluIG9uZSBpYi9ldGggZGV2aWNlPw0KPiBJZiB5ZXMsIGF0IGxlYXN0IGZvciBJ
QiwgaXQgd2lsbCBiZSB2ZXJ5IHVuZXhwZWN0ZWQgdG8gc2VlLg0KPiANCkFkYXB0ZXIgaXMgSUIg
c3BlY2lmaWMgYW5kIG9uZSBwZXIgVkYvcGNpZSBkZXZpY2UuIEl0J3MgdGhlIGhhbmRsZSB0aGF0
IGlzIHBhc3NlZA0KYmV0d2VlbiB0aGUgbWFuYWdlbWVudCBhbmQgVk0gZm9yIGJvb2sga2VlcGlu
Zy4NCj4gV2h5IGRvIHlvdSBoYXZlIGNsaWVudCBhbmQgZGV2aWNlIHdoZW4gdGhleSBhcmUgYmFz
aWNhbGx5IHRoZSBzYW1lIG9iamVjdHM/DQo+IA0KSSBhbSBub3Qgc3VyZSB3aGljaCBvbmVzIHlv
dSBhcmUgcmVmZXJyaW5nIHRvIHNwZWNpZmljYWxseSAsIGNhbiB5b3UgcGxlYXNlIGVsYWJvcmF0
ZT8NCg0KPiA+IFBsZWFzZSBub3RlIHRoYXQgdGhlc2UgYXJlIHRlcm1zIHVzZWQgZm9yIGRpZmZl
cmVudCBwdXJwb3NlcyBvbiB0aGUNCj4gbWFuYWdlbWVudCBzaWRlLg0KPiANCj4gV2UgYXJlIGRp
c2N1c3NpbmcgUkRNQSBzaWRlIG9mIHRoaXMgc2VyaWVzLg0KPiANCj4gVGhhbmtzDQo+IA0KPiA+
DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+DQo+ID4gPiA+ID4gU2VudDogTW9uZGF5LCBT
ZXB0ZW1iZXIgMTEsIDIwMjMgNzozMyBBTQ0KPiA+ID4gPiA+IFRvOiBzaGFybWFhamF5QGxpbnV4
b25oeXBlcnYuY29tDQo+ID4gPiA+ID4gQ2M6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29t
PjsgSmFzb24gR3VudGhvcnBlDQo+ID4gPiA+ID4gPGpnZ0B6aWVwZS5jYT47IERleHVhbiBDdWkg
PGRlY3VpQG1pY3Jvc29mdC5jb20+OyBXZWkgTGl1DQo+ID4gPiA+ID4gPHdlaS5saXVAa2VybmVs
Lm9yZz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+ID4gPiA+ID4g
RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kNCj4gPiA+
ID4gPiA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsg
bGludXgtDQo+ID4gPiA+ID4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh5cGVydkB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgQWpheQ0KPiA+ID4gPiA+IFNoYXJtYSA8c2hhcm1hYWpheUBt
aWNyb3NvZnQuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQYXRjaCB2
NSAwLzVdIFJETUEvbWFuYV9pYg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMDcs
IDIwMjMgYXQgMDk6NTI6MzRBTSAtMDcwMCwNCj4gPiA+ID4gPiBzaGFybWFhamF5QGxpbnV4b25o
eXBlcnYuY29tDQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBBamF5IFNoYXJt
YSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IENo
YW5nZSBmcm9tIHY0Og0KPiA+ID4gPiA+ID4gU2VuZCBxcCBmYXRhbCBlcnJvciBldmVudCB0byB0
aGUgY29udGV4dCB0aGF0IGNyZWF0ZWQgdGhlIHFwLg0KPiA+ID4gPiA+ID4gQWRkIGxvb2t1cCB0
YWJsZSBmb3IgcXAuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWpheSBTaGFybWEgKDUpOg0K
PiA+ID4gPiA+ID4gICBSRE1BL21hbmFfaWIgOiBSZW5hbWUgYWxsIG1hbmFfaWJfZGV2IHR5cGUg
dmFyaWFibGVzIHRvDQo+IG1pYl9kZXYNCj4gPiA+ID4gPiA+ICAgUkRNQS9tYW5hX2liIDogUmVn
aXN0ZXIgTWFuYSBJQiAgZGV2aWNlIHdpdGggTWFuYWdlbWVudCBTVw0KPiA+ID4gPiA+ID4gICBS
RE1BL21hbmFfaWIgOiBDcmVhdGUgYWRhcHRlciBhbmQgQWRkIGVycm9yIGVxDQo+ID4gPiA+ID4g
PiAgIFJETUEvbWFuYV9pYiA6IFF1ZXJ5IGFkYXB0ZXIgY2FwYWJpbGl0aWVzDQo+ID4gPiA+ID4g
PiAgIFJETUEvbWFuYV9pYiA6IFNlbmQgZXZlbnQgdG8gcXANCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEkgZGlkbid0IGxvb2sgdmVyeSBkZWVwIGludG8gdGhlIHNlcmllcyBhbmQgaGFzIHRocmVlIHZl
cnkgaW5pdGlhbA0KPiBjb21tZW50cy4NCj4gPiA+ID4gPiAxLiBQbGVhc2UgZG8gZ2l0IGxvZyBk
cml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS8gYW5kIHVzZSBzYW1lDQo+ID4gPiA+ID4gZm9ybWF0
IGZvciBjb21taXQgbWVzc2FnZXMuDQo+ID4gPiA+ID4gMi4gRG9uJ3QgaW52ZW50IHlvdXIgb3du
IGluZGV4LXRvLXFwIHF1ZXJ5IG1lY2hhbmlzbSBpbiBsYXN0DQo+ID4gPiA+ID4gcGF0Y2ggYW5k
IHVzZSB4YXJyYXkuDQo+ID4gPiA+ID4gMy4gT25jZSB5b3UgZGVjaWRlZCB0byBleHBvcnQgbWFu
YV9nZF9yZWdpc3Rlcl9kZXZpY2UsIGl0IGhpbnRlZA0KPiA+ID4gPiA+IG1lIHRoYXQgaXQgaXMg
dGltZSB0byBtb3ZlIHRvIGF1eGJ1cyBpbmZyYXN0cnVjdHVyZS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRoYW5rcw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIGRyaXZlcnMv
aW5maW5pYmFuZC9ody9tYW5hL2NxLmMgICAgICAgICAgICAgICB8ICAxMiArLQ0KPiA+ID4gPiA+
ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jICAgICAgICAgICB8ICA4MSAr
KystLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYyAgICAg
ICAgICAgICB8IDI4OCArKysrKysrKysrKysrLS0tLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmggICAgICAgICAgfCAxMDIgKysrKysrLQ0KPiA+ID4g
PiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMgICAgICAgICAgICAgICB8ICA0
MiArKy0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9xcC5jICAgICAg
ICAgICAgICAgfCAgODYgKysrLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L21hbmEvd3EuYyAgICAgICAgICAgICAgIHwgIDIxICstDQo+ID4gPiA+ID4gPiAgLi4uL25ldC9l
dGhlcm5ldC9taWNyb3NvZnQvbWFuYS9nZG1hX21haW4uYyAgIHwgMTUyICsrKysrLS0tLQ0KPiA+
ID4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYyB8
ICAgMyArDQo+ID4gPiA+ID4gPiAgaW5jbHVkZS9uZXQvbWFuYS9nZG1hLmggICAgICAgICAgICAg
ICAgICAgICAgIHwgIDE2ICstDQo+ID4gPiA+ID4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgNTQ1IGlu
c2VydGlvbnMoKyksIDI1OCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAt
LQ0KPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPg0K


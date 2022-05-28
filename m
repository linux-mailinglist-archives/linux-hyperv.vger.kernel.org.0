Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F4536D13
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 May 2022 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiE1NSP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 May 2022 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiE1NSP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 May 2022 09:18:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C419FBF;
        Sat, 28 May 2022 06:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNliV6J53P/Vz0a+e/1nDMq0F99kfPB/b+Ms2RN1+P357pVwBWUqgz4bIRzr1j7JsMpfEVjh0eY0NlPvUBIege0f8E1mXoZH9cSR4TTKZgP+tF4VygKLjgwQdzg1lGMWx6gTE4NbMfU9ZR0GiSA+YcTaE+tYClXuZLfQuvprOp06Hnv1xMZ98nuHoJt2JuigYgmiy8bub3Ci8Z8+Dr+Jj3aRLhDQJKH2TW4W4rIPy3iEndLyFIxgebrPsxR5z2l2E0ACEqlKOwy5+4l9GbNzeqKHVN5stMY/tH/H7staJnfvcSD8ttvH8XIzpWmSJWUlCpS9PYKsAv06741w6xYUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fO+0efooAOw9dAOw3m7GUmWdZb+eEIiwgNf8InPtCU=;
 b=A/APm6+sCJjloMtswCsCshMLbV4xs6CsIjHoE4SlHcKH1n6dR4kgxt97cGOcAumzoQzgVDHRY2dCy8x7Y8j6cXjx6Ptw1UNZpaGmAtX+LDafXkqQ9CWTr2iZAfb0DXMaCJkMzfBFplfEx4njd8B1YbGuiEq4ES664o7tKTlDVkVsMi6w5cy/62kCGxalOCshgqVOomIUViOhEp+ApGqyKU7Gb7S3Givz8emUTOLnAl4le+hVFxDb9wT3MU3IlontGEH+6rXFl/PFvGZmWkodmwjpHShFG+QLS+hw3T2nWXmS4DWUpt59BHRlHUq+om/gidnH4pGZrT8JsoYU2UY/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fO+0efooAOw9dAOw3m7GUmWdZb+eEIiwgNf8InPtCU=;
 b=EzkH04ErcF0m99/CWMW9R1CUVa4Nr74jZVa+ecI+mD2PxK8xuZtx/fzwme6G5R7YCSw9Xci9NGu7u9h1dPcSreeCm3EcRcedNCLuQcmOYaT2VurAg7lRxrb3S51k3dR2GJJNkDV4yLtfDLQRG2HGas2xTksNVDhh9O8KikcU4U8=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by DM6PR21MB1322.namprd21.prod.outlook.com (2603:10b6:5:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.0; Sat, 28 May
 2022 13:11:22 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::685f:28e3:d3f:b6e3]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::685f:28e3:d3f:b6e3%7]) with mapi id 15.20.5332.000; Sat, 28 May 2022
 13:11:22 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [RESEND PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Topic: [RESEND PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Thread-Index: AQHYcZ2LN4T1gHx6Ak+obtqDeol3kK00RSBQ
Date:   Sat, 28 May 2022 13:11:21 +0000
Message-ID: <BY3PR21MB30338E99CC13116ECAB27BD7D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1653637439-23060-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653637439-23060-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70bbeff2-8850-419b-878c-dcd80df82c5e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-28T13:09:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c7ec6f-12e9-421e-b8f7-08da40ab8f8b
x-ms-traffictypediagnostic: DM6PR21MB1322:EE_
x-microsoft-antispam-prvs: <DM6PR21MB13222F59FCBA99C4C8D23A16D7DB9@DM6PR21MB1322.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UP/iMQ5K/YO7yJ1foFadJ0GTotZAQhfpsD4oRx4Ygi9ZTjvvgrAieb7e8Kbs90HUEiX5QIWO+MSfXxZxSPio1n2D71gPzETlXyP8HRsPSGlXSK7kDj+G9Y3zKsCZtTlFva33eD2foHae0YoaaOpg+tYu65r9K5HrUdIQRYgEZGfIm9MI94DhI3y41RvmcTeTs8fLuWJvEpTEqBNA4IwVPPt79OePdZOm0tpSCGW9B3IgusGnaI3pTTMjWqqN7wba7Obv64qXBvpe3SnlhMVI/ZjiNzfk4uoyOr8WePB/Vqqjvy2sUx0Rig1rbckkaL9oUSWAtoLacHz3fl01E/uvW63blae4bkLINP0iA8q4tjHBt8XBPI4LzDbDTRpx2aPi4ADfJlIqaohUONCm/gg5NwdQDPituzSWqeVyEKVfyXpXNgH+Ba06SslIRPVuB+ABzeIhL4Ky+9XlQevD/VCs11cbptuhZ4QDa1WAow2V9/mL+ByzFbxM3W06K/c7wjvde+NbEPzUc45F9X96AeOeIp+orgVXm7fqFkQvCv9WpZajl2uh8A8QuLc6NEKuyIbQrgdOviM1sBEFKWq7YZF4nxwkYjF2ABHflhkdEzyutAzHKfe8UcDRUoArSdaFU0xGm8CNY747V1RCU3aJg/uV7PZQnBGhN3Jtu+8oo0WaW7LBVwFPHMcgsoQ7I/bSXJNjgm0+CpcAGFGTCNO6GjbjQG39OHBAql9UwIHVZSQj3mqvhsdlqbEvKlLoOEOFMmtX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(122000001)(186003)(76116006)(8676002)(86362001)(110136005)(6636002)(7696005)(38070700005)(52536014)(2906002)(8990500004)(82960400001)(83380400001)(82950400001)(38100700002)(508600001)(9686003)(316002)(26005)(6506007)(8936002)(66446008)(55016003)(64756008)(66946007)(66556008)(66476007)(71200400001)(33656002)(5660300002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdCSVJyNWtlWDRWTVpNR2pZOXcrN29kOVp3cTh3RGIvWSt5ak5qTnBra2dH?=
 =?utf-8?B?UHVmbE5lQWtZTUowRUNEVVQvczMwVFJTWlBkRmFsb0hLK0V6bVM3M3lkbjlC?=
 =?utf-8?B?RWFPamg0Z3BBbUhpRFlpWjF0dm91eGZEb01lSm91Uys1ZkMyRjRMY2gzM0Z6?=
 =?utf-8?B?Z1dsRlZHMnN6K1VTWS9OSnVvbUFicksrVWxYQmk5bGV1WGZpZjRIOEg1dXMx?=
 =?utf-8?B?Q1BFVzJvS1Y3VkpQdzRadmhTb2NHczRnVmZJaXVzUGhLTVhGUnI0SlNGM2N1?=
 =?utf-8?B?a2NjUTFTT1N5QVQxNldHOUZSUytXZ3Z6SCtiaVhXSk9oazNXUGJEL2pJS2ow?=
 =?utf-8?B?Tit2V0tYZkFnY0ZLMVlZeUZtc0lKajk2U09waHFENmkvbno0cERnV0p5RU9u?=
 =?utf-8?B?bWZqaFltaGFjbkphWEJpaExmaE9uak9rSURBbDl6N0s2N0FzWEZWVk1rNlg3?=
 =?utf-8?B?OERoaFlNUWNwWUE0VGpKdFA0ZjBCbHFTd3V4a0YvRmU1TVdrMStLT1gwRVFu?=
 =?utf-8?B?WFJtYTI1bzFuQVZzUzRPeXVlOHFwaHkwcktzeko2UThuOGNyU0U4ZnhiTlVa?=
 =?utf-8?B?bUtqVUdGcHJ1LzBCRWM3N1RlSm5UV3EvWnBQUy9sMXFDUHNoSi9ESGFUSTNz?=
 =?utf-8?B?QVpNTEljMFZxMWZoN29ISitxbzNBREhNOGRjNXBDNk5IRFRiT05tQ2M4OURs?=
 =?utf-8?B?K2VDT0l1eVFvblF5TFUxVzlFMEJnQWVKRzlZMENsWjZnOFNDQkdIUWdVVVJE?=
 =?utf-8?B?K3h4SFV5NE1jdkhSenE5Tk1iemFEWGRVcGVyd1ova1V6UStPYjE4QTJBc05t?=
 =?utf-8?B?bTQrUE5aVmRFOUd4RzVQc1JWSTl2VXlYR1N0MmFCaC9MMngrM2QvWFZJRkRs?=
 =?utf-8?B?ME9LWGhjMmJrcmxUb3gvMTN6QXgwanUxL1R4bFBjayt6RERuUHhaNU1YN28z?=
 =?utf-8?B?ckd3QUh5aDE2cEw1R0hJQTRtSlBkQUpibzVpQlNjMExXR3BEMG15ZTdmS3py?=
 =?utf-8?B?QWxMZmZKSWlTdmI4bk1rNXllTVZ3c1h6Wmg5eHlZNUE0OEtFMUp4eWNTdnZp?=
 =?utf-8?B?WkVqMzVSTmVJZWk3cU9qdW5HQkFBRTZWVkt4dDdBZWwrbEhOcEZyemNWYW5Z?=
 =?utf-8?B?MXlISW5oUm1UZkRVd2MvSitnMGoyem95aGdSMVZMVmk4Y09kUWtiaVAwekFi?=
 =?utf-8?B?WXU3QjJHZ0xrUnMzNGdsc3FtZjNLRlYwV2lHdWcxckxJUE56QkxxVkRQRnd3?=
 =?utf-8?B?bTFKRXdHV2N2SWNNOFNCRGJya3FDUGp2cVg5M3BQNkJXNlFYbkZGZFg2cVFP?=
 =?utf-8?B?bFBmQWtKbWFqdXRBTmJ1djg4VEUzQzhHWjlDZFFOc3drejlNYUFWWVhjZ1ZO?=
 =?utf-8?B?bjhVcW1kTlM5MWp0YS81QXcyV1NGSTl2VGRhSzduWGwwekpqQUFhWUR4S2g4?=
 =?utf-8?B?QW93cXZKcjBEVWkyZmlUZzRCMVZUTGhzdTRjUnJnZkVPNGdwbVBtZXo5K2Iw?=
 =?utf-8?B?NTV6ejJiNVo1YVJJaVg3QUFHTzVkSk05SEJ1a21rUEJ4Y1BYWmo2Y2lpOHdJ?=
 =?utf-8?B?czd2TWw5bGFhNEJ0MndzTEdlN1lKVXRtcHhhLzM4TEFKOEowR0pGbnZmeDhX?=
 =?utf-8?B?UGJnN3RwSXNGMU5rUkdhajcrSGdnQTlSUWtCdjZlMG1BdXJiQURxMlowamtT?=
 =?utf-8?B?aVpXS1VVSllRN2Z6UUhCeDF1OEU1bzN2Q3BCZzFBUUtNRy9OVVd2RS95S04w?=
 =?utf-8?B?TlV1eWRNckJhN0ZneTlzZEkwUmtlV0x5ekJRQUZvY2dSSG1aWGw5Q3ppWi9n?=
 =?utf-8?B?WFJ4SzgzUWNqU0s1bTJ6cG44R1NCcWQzOVhkMEdBcHBEbzJCSXI0Smh4dEZp?=
 =?utf-8?B?L0x1WnJtOUhrV0ZaSnE3cWlCZGU3RGxvcVRjbVBGSFNMeHF6QTZwWWttWS9X?=
 =?utf-8?B?MDUyNXJpRzkxSjExWHpwdnNoNjJuYnZ0M0xvVGg0VXp1dVRSQTF5ZzZFWjds?=
 =?utf-8?B?Nzk4eER0bjlaQWZ3RnJlaEY3QmZQU3pTYTVDanBFSGpjZnk1V04rNC9IQnM4?=
 =?utf-8?B?bVFmeG5wOUFLcDJzUFN4L0piY3pCbTVYb2dYNzVRNG9WdTkvMEl4bEJDajFR?=
 =?utf-8?B?VFE2eThsSU5BeURvdU1teklDd0k3dWVmN2J4S1M5UURzdmdrOTFIMmlPUFJJ?=
 =?utf-8?B?U2cwTUlQVm04blcwNXFTMXA3RE1Oa3RuZ1JFMnQya3ZMdFZlSFozek1PdTRN?=
 =?utf-8?B?QzlUT1ZTRXR4NmUwUTczODN2MjMvVm1jUGxvMm1EZ3V1RnJkaDc0UGF1enB4?=
 =?utf-8?B?WTFCOVE2K0FHOWZsL29pNEhKdXM2a1YyWVNYcllvd1NPZ3NpYjZaUjh6ZmJt?=
 =?utf-8?Q?iR0gcLxNcLa9dv8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c7ec6f-12e9-421e-b8f7-08da40ab8f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2022 13:11:21.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SiEZx7G88FBBk6q4ZGQ+SHzqC5YPmDOYs2i15BuZ5bzHI2j+NJee6BtjN/vgCbQgIl7wug8uR1ErqmqATHmVuqoToP7lxBwBI+HMFIr8K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1322
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU2F1cmFiaCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDog
RnJpZGF5LCBNYXkgMjcsIDIwMjIgMTI6NDQgQU0NCj4gDQo+IFdoZW4gaW5pdGlhbGx5IGFzc2ln
bmluZyBhIFZNYnVzIGNoYW5uZWwgaW50ZXJydXB0IHRvIGEgQ1BVLCBkb27igJl0IGNob29zZQ0K
PiBhIG1hbmFnZWQgSVJRIGlzb2xhdGVkIENQVSAoYXMgc3BlY2lmaWVkIG9uIHRoZSBrZXJuZWwg
Ym9vdCBsaW5lIHdpdGgNCj4gcGFyYW1ldGVyICdpc29sY3B1cz1tYW5hZ2VkX2lycSw8I2NwdT4n
KS4gQWxzbywgd2hlbiB1c2luZyBzeXNmcyB0byBjaGFuZ2UNCj4gdGhlIENQVSB0aGF0IGEgVk1i
dXMgY2hhbm5lbCB3aWxsIGludGVycnVwdCwgZG9uJ3QgYWxsb3cgY2hhbmdpbmcgdG8gYQ0KPiBt
YW5hZ2VkIElSUSBpc29sYXRlZCBDUFUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYXVyYWJoIFNl
bmdhciA8c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gdjI6ICogUmVzZW5k
aW5nIHYyIHdpdGggbWlub3IgY29ycmVjdGlvbiwgcGxlYXNlIGRpc2NhcmQgdGhlIGVhcmxpZXIg
djINCj4gICAgICogYmV0dGVyIGNvbW1pdCBtZXNzYWdlDQo+ICAgICAqIEFkZGVkIGJhY2sgZW1w
dHkgbGluZSwgcmVtb3ZlZCBieSBtaXN0YWtlDQo+ICAgICAqIFJlbW92ZWQgZXJyb3IgcHJpbnQg
Zm9yIHN5c2ZzIGVycm9yDQo+IA0KPiAgZHJpdmVycy9odi9jaGFubmVsX21nbXQuYyB8IDE3ICsr
KysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jICAgIHwgIDQgKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hhbm5lbF9tZ210LmMgYi9kcml2ZXJzL2h2L2No
YW5uZWxfbWdtdC5jDQo+IGluZGV4IDk3ZDhmNTYuLjEyN2EwNWIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaHYvY2hhbm5lbF9tZ210LmMNCj4gKysrIGIvZHJpdmVycy9odi9jaGFubmVsX21nbXQu
Yw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2h5cGVydi5oPg0KPiAgI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlvbi5oPg0KPiANCj4gICNpbmNsdWRlICJoeXBl
cnZfdm1idXMuaCINCj4gDQo+IEBAIC03MjgsMTYgKzcyOSwyMCBAQCBzdGF0aWMgdm9pZCBpbml0
X3ZwX2luZGV4KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsKQ0KPiAgCXUzMiBpLCBuY3B1
ID0gbnVtX29ubGluZV9jcHVzKCk7DQo+ICAJY3B1bWFza192YXJfdCBhdmFpbGFibGVfbWFzazsN
Cj4gIAlzdHJ1Y3QgY3B1bWFzayAqYWxsb2NhdGVkX21hc2s7DQo+ICsJY29uc3Qgc3RydWN0IGNw
dW1hc2sgKmhrX21hc2sgPSBob3VzZWtlZXBpbmdfY3B1bWFzayhIS19UWVBFX01BTkFHRURfSVJR
KTsNCj4gIAl1MzIgdGFyZ2V0X2NwdTsNCj4gIAlpbnQgbnVtYV9ub2RlOw0KPiANCj4gIAlpZiAo
IXBlcmZfY2huIHx8DQo+IC0JICAgICFhbGxvY19jcHVtYXNrX3ZhcigmYXZhaWxhYmxlX21hc2ss
IEdGUF9LRVJORUwpKSB7DQo+ICsJICAgICFhbGxvY19jcHVtYXNrX3ZhcigmYXZhaWxhYmxlX21h
c2ssIEdGUF9LRVJORUwpIHx8DQo+ICsJICAgIGNwdW1hc2tfZW1wdHkoaGtfbWFzaykpIHsNCj4g
IAkJLyoNCj4gIAkJICogSWYgdGhlIGNoYW5uZWwgaXMgbm90IGEgcGVyZm9ybWFuY2UgY3JpdGlj
YWwNCj4gIAkJICogY2hhbm5lbCwgYmluZCBpdCB0byBWTUJVU19DT05ORUNUX0NQVS4NCj4gIAkJ
ICogSW4gY2FzZSBhbGxvY19jcHVtYXNrX3ZhcigpIGZhaWxzLCBiaW5kIGl0IHRvDQo+ICAJCSAq
IFZNQlVTX0NPTk5FQ1RfQ1BVLg0KPiArCQkgKiBJZiBhbGwgdGhlIGNwdXMgYXJlIGlzb2xhdGVk
LCBiaW5kIGl0IHRvDQo+ICsJCSAqIFZNQlVTX0NPTk5FQ1RfQ1BVLg0KPiAgCQkgKi8NCj4gIAkJ
Y2hhbm5lbC0+dGFyZ2V0X2NwdSA9IFZNQlVTX0NPTk5FQ1RfQ1BVOw0KPiAgCQlpZiAocGVyZl9j
aG4pDQo+IEBAIC03NTgsMTcgKzc2MywxOSBAQCBzdGF0aWMgdm9pZCBpbml0X3ZwX2luZGV4KHN0
cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsKQ0KPiAgCQl9DQo+ICAJCWFsbG9jYXRlZF9tYXNr
ID0gJmh2X2NvbnRleHQuaHZfbnVtYV9tYXBbbnVtYV9ub2RlXTsNCj4gDQo+IC0JCWlmIChjcHVt
YXNrX2VxdWFsKGFsbG9jYXRlZF9tYXNrLCBjcHVtYXNrX29mX25vZGUobnVtYV9ub2RlKSkpIHsN
Cj4gK3JldHJ5Og0KPiArCQljcHVtYXNrX3hvcihhdmFpbGFibGVfbWFzaywgYWxsb2NhdGVkX21h
c2ssIGNwdW1hc2tfb2Zfbm9kZShudW1hX25vZGUpKTsNCj4gKwkJY3B1bWFza19hbmQoYXZhaWxh
YmxlX21hc2ssIGF2YWlsYWJsZV9tYXNrLCBoa19tYXNrKTsNCj4gKw0KPiArCQlpZiAoY3B1bWFz
a19lbXB0eShhdmFpbGFibGVfbWFzaykpIHsNCj4gIAkJCS8qDQo+ICAJCQkgKiBXZSBoYXZlIGN5
Y2xlZCB0aHJvdWdoIGFsbCB0aGUgQ1BVcyBpbiB0aGUgbm9kZTsNCj4gIAkJCSAqIHJlc2V0IHRo
ZSBhbGxvY2F0ZWQgbWFwLg0KPiAgCQkJICovDQo+ICAJCQljcHVtYXNrX2NsZWFyKGFsbG9jYXRl
ZF9tYXNrKTsNCj4gKwkJCWdvdG8gcmV0cnk7DQo+ICAJCX0NCj4gDQo+IC0JCWNwdW1hc2tfeG9y
KGF2YWlsYWJsZV9tYXNrLCBhbGxvY2F0ZWRfbWFzaywNCj4gLQkJCSAgICBjcHVtYXNrX29mX25v
ZGUobnVtYV9ub2RlKSk7DQo+IC0NCj4gIAkJdGFyZ2V0X2NwdSA9IGNwdW1hc2tfZmlyc3QoYXZh
aWxhYmxlX21hc2spOw0KPiAgCQljcHVtYXNrX3NldF9jcHUodGFyZ2V0X2NwdSwgYWxsb2NhdGVk
X21hc2spOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2
ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+IGluZGV4IDcxNGQ1NDkuLjU0N2FlMzMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9odi92bWJ1c19kcnYu
Yw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbF9zdGF0Lmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvY2xvY2tjaGlwcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nw
dS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2lzb2xhdGlvbi5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L3NjaGVkL3Rhc2tfc3RhY2suaD4NCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4NCj4gQEAgLTE3NzAsNiArMTc3MSw5IEBAIHN0YXRpYyBzc2l6ZV90IHRhcmdldF9jcHVfc3Rv
cmUoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsDQo+ICAJaWYgKHRhcmdldF9jcHUgPj0g
bnJfY3B1bWFza19iaXRzKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICsJaWYgKCFjcHVt
YXNrX3Rlc3RfY3B1KHRhcmdldF9jcHUsIGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfTUFO
QUdFRF9JUlEpKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gIAkvKiBObyBDUFVzIHNo
b3VsZCBjb21lIHVwIG9yIGRvd24gZHVyaW5nIHRoaXMuICovDQo+ICAJY3B1c19yZWFkX2xvY2so
KTsNCj4gDQo+IC0tDQo+IDEuOC4zLjENCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxt
aWtlbGxleUBtaWNyb3NvZnQuY29tPg0K

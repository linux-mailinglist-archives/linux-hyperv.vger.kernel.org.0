Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65146916F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Feb 2023 03:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjBJC6D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 21:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJC5r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 21:57:47 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006F721C7;
        Thu,  9 Feb 2023 18:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3dvXU9pj5X+Uklk0fuwQcBzjkrx0+3nHAHvTXprZ1yhLTt3a7exjAQjUDYVuLuBEcBIi1AhltIpV7kmSQHMLDAMn/UFPr/VNETprZoIxI8aw25jaDUM6E+KzfWy0uBE+ySpTwdnakI0FRxn6VbC1v/54oLz5X3IGJABSYjjPqzDNGGMEM78SWsfBfNFIg0vCoW9vuSo2difQpUGzP45KpqvTZnokmLnPU328zxaF85QBXH7ozkxHzTBIfKI2QJUZUYqtXLIQDJhmHAv8pA2Kjin8gYyzrkAEcGNTUHxIBX9Z0dkp2XQbOMndADjZ09qaFtDxW18ILySC4wUyjPDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vtb0s2QmzpgSZntQ7KEI38RNUDr7sJMJxWkjXSRjjo=;
 b=AlK/qZT8XpjEoK3aHqOHZMt3J4rlJijiRxtHz5kZXJhYUVOr2HFUABwDQAxpQPRM1lhu767TrYhGR1/E1CPXcl0LXPhWvEKw9hPaFLJ29fHFdbsdE3EsOLjzDJQ+TjAOopxN2DkINBj5jV+WT7c+0XUBzFsvZYrnghVeBhasvQ9lCO3OxpMLOKoa3i72ZJoHL4DQRizR/9s/1jtILM35FNBYK0DdBbsoaCo6BK3bNiVCCRxNThGnit8sRbVLPxPxOWE4bciamUy6m5MChAen6kyANFSJi0z0Le74fvtngEEDSks8DaKItVfXwf3fxbmbL8/LD76Ei70QTagtL+3AKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vtb0s2QmzpgSZntQ7KEI38RNUDr7sJMJxWkjXSRjjo=;
 b=AQPtAYwnIhYTmDQ+ZhdjRL2Vn7MTCKvFDSE9Ypy/1pLaKjwF/iGAK+SOQ/lp3MmOyOy7Qp8Ksr/Kvb0qdsXRRnFcDfvdp7okykq9ORMZ4vS8SX4+6uc0rC5/ouhzOoz0XNICk2HXyOU3FXIZXbiv1+KUcCXe0Qu91enSrtaWxLQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3246.namprd21.prod.outlook.com (2603:10b6:8:7e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Fri, 10 Feb
 2023 02:57:22 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9%2]) with mapi id 15.20.6111.005; Fri, 10 Feb 2023
 02:57:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZO7FcvtVZ42Ia+EWsc9sfieb8y67FZwQggAD41GWAARZlwA==
Date:   Fri, 10 Feb 2023 02:57:22 +0000
Message-ID: <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230208113424.864881-1-mgamal@redhat.com>
 <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
 <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com>
In-Reply-To: <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a760f7d-93d2-4924-bd74-01a899172503;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-10T02:24:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3246:EE_
x-ms-office365-filtering-correlation-id: 9dcdc8c7-d872-4363-0cd0-08db0b128834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X55Meyzt5B7B/VJvDv/nfWBqoKhHqaEYJMc+mO4kiicRse9j+Xua5U9tV94L7Q20tq9qBVW6VRYZYQ4d6pYbam6F4t/YUP8KgfymKlujpfBHLcVHYtHQrfaYTNl1HgcCHzr8Bd5w+fhrx6Nd7aEtzzoqC0S/tlfCeT6bX31DRinh198mOl39/4wu1HE5tFJpCJb2S38T/EWYVVYFJsnXLhzINmW6nyw+PzxWYnELLv1bbN2gMR6m0bnfaB1ICtRERPvw+pp/PeWGUwqBvCQ5ZtR4q/Gq6rSkScF9nvv5Fc/KLJG3YGTUFPOGTFlT5i6AVpgA0ph8gDVXvCiWp96b/AzZLnnLvbUXrNW+MFqCrQHcFY/9VJW7ZkTaDPPfQ44ddzdVg/oRqG1HK0MuSn9jx5Irp30q8LP2XYqwu+r+aCIG/MND3muhtF7CVmbEu34Ijp5mnwDmFNGQAzL7Fd5+VTDoXkvqwzbi0lkPqNiEAmjhvvtci8oyXJzTEwT83ss5pA8KekhN2mtfkJ90nx4WeXMMKJxm7TTra4Voshwg4swg4cE8YIzzAMrpetrLTDLDGr4Sd4OJ3IIHGVbk+zP3fDAF63C1XzEceEcaOxRmDmsmSfx5eiTuiyOJWifj5KwFGe/JmzYTcf6UiTMiF/geGfDoLafgtqjqIDfroU6lIogRovBglaJQGFeiVBWAuWoHkPIiWZzvB1qpMKpEF2DnABP41p0/rsGn4c8g2K46t9fbSiTF4qLp+i2TeWKrMUSl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199018)(2906002)(86362001)(38070700005)(8990500004)(38100700002)(82960400001)(82950400001)(122000001)(66446008)(7696005)(71200400001)(9686003)(10290500003)(26005)(186003)(33656002)(55016003)(76116006)(64756008)(66556008)(83380400001)(54906003)(316002)(66946007)(478600001)(4326008)(8676002)(41300700001)(6916009)(6506007)(8936002)(52536014)(5660300002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2dXazFGKzdxa2NvR0VIMU1OTGpKZE9VUTg4SGp4UmdLSEpBQW41MGZWNnBi?=
 =?utf-8?B?N1ovVXFaQjgwSDU5VlNDZmZqUyswNC9aR0ZneEpuRkw0Q2tzMVRlNU9nejds?=
 =?utf-8?B?a1RBSVBMMUppRnBlbnNwS2RqaHRUWUxIa0lRYWQ1Qm1mekQ2Z3lvY1B0UlQ4?=
 =?utf-8?B?Ry9jNDQ0cG1PZ3Jwc2N5RG82QTFSaklMczRVV3RhYjh1Zk9ybGduVVAvN1J5?=
 =?utf-8?B?MnlmWDVhWFVlUlJXcm9Ia3dqVUo0VmRuYzJhV1VRWjNUSHJ4UGx4MStXcWRw?=
 =?utf-8?B?ZFg3akg5ZksrQnBERkRuN3ZkdWFlbXZZWk9reEVwTDEyTEtFNDA3M1RLWXNT?=
 =?utf-8?B?VGdMZm53bUxnNlZsbm5MemJTa1A1MjJmV2gweDJOQ3FTdGFEM1Z1RlBEb1g1?=
 =?utf-8?B?Y3dQSjhKbkNyQUpZQkx2YTIyRFpRelk2S1p1Sjd4NkgvTm9Ea2tRY3V2N0pz?=
 =?utf-8?B?Mkl1dkZIRFJPcVlLM2VGM093SHZ4Ti9iVkFXZVVpSlBERmNKclE3eGM0bm1J?=
 =?utf-8?B?NzVzRXNlMFRSekd3a2lVWnZ1OHo3TUhPREZTUjBEaHJqZFJmQUVqTi9HM3V2?=
 =?utf-8?B?YTVCVzJISDRETzFhVVpCUWx4S2ppSG10ajdvdkU1ZkNmbDJ5N1o4UHlmK2RN?=
 =?utf-8?B?b3BNbHBqdWd5V1hubVdhZDVMVFJyNWdKZjRBS285WEp3bk4vdC9YMU1naVBq?=
 =?utf-8?B?MFFRWldYM0YzSldaZHU3dExwZ1dXWmQ2WXdRaHB4UUcyb0RDZmUvdkdVUVhP?=
 =?utf-8?B?TlkvNGFabWxLa1BWNWE2OXFvZ1ovTGdmbmFKRUM4U0ZWeU1uSElMM0dsUTZC?=
 =?utf-8?B?NWJPaU1ORjhpMEROODZmL0MxRWVGVU1GMzZTN1hyeWdpMWhsR2pYajcrMW5D?=
 =?utf-8?B?OG5tK3NFU01LT0JwRGs2NW9ZSk9TcnBUc1lObUJXdWh5V0V2Wk5FL2J3VGxX?=
 =?utf-8?B?eHR3QmtJTzhyS1huSWtZdWhyZWhOSXNuTXRHa3Era28zSmpSSDh5VnNSdFhz?=
 =?utf-8?B?QjFJVC9udGhiVVJkZEdpUk5iVnhsNnR1a1BNeG5IMkFGTzlPekYrbnY1dFBZ?=
 =?utf-8?B?MkVMSUc1YVlUb1E5eXNQZmJkWFdYM091L0d5RXhKTlNuUW9QTWk5VEh4eWxS?=
 =?utf-8?B?cmx3WVhNQTVacFBoY2p6UWRKMHJqUkNWcUxpcmpIWjNNMDV6ZE8zV3VxVmhw?=
 =?utf-8?B?V2VKL3pLeWJobGFzYjZ1OGc2M21ySlU3cWZYRDZlalNSY21vS0htMHZFVEJw?=
 =?utf-8?B?QVNvV3lxdUpqLzFsZ2lTL2o3bUxraGhRK2sxWmdZUnRnQTZCWmdjUHBlcXNO?=
 =?utf-8?B?WWg5SVp2Ulp4WUpnc2pqS3dkbk5kNmZkUnMzQ0dLL2pPN2NFNCt3RmxPKzRo?=
 =?utf-8?B?cXNRUUpSdFkyWlBFTzlMSTNrZUNKRU1ZUDVPSmtqVDBVM1psQ0pxNUlhUlhn?=
 =?utf-8?B?OHlWdThtRU1jSm1NOFN5VWgxZlJWWFNsOTJCNHRqSlp5TzFvMzg2bHJPR1BO?=
 =?utf-8?B?dW5la3R5TjJ3SFlmRE44VEF0MW90enhPMEJObGJGeEtoeTQ3UVI1dEFtTSsw?=
 =?utf-8?B?TE9iSEZuYUN1YXVRcG9BRWNVTE5EY3crMWlaQUN1WUJSR3d2em9GTCtQWUd6?=
 =?utf-8?B?NVUwYVlrT3pBbkIrTHVKYlhoZXpWQ1hHd083MkJwa2V0dnhDR2Y2cDNTdUJO?=
 =?utf-8?B?KzNiZkt2eE1zcVdXK1RDSXNMb09FUWlTQStzYk9Hcll4RWgzREljM09pUXkw?=
 =?utf-8?B?ZEFPVnVrdndJUm1kK2NEaVlvSE14S1BDbG1RblQ5Y24rdlM3YWRPdXdaZTlB?=
 =?utf-8?B?ZUQ0SnF4UUswMkNoamsvQWdmbkVhVG4yaWJtTnZtYlRYTEkxQU5SL3MyaVJD?=
 =?utf-8?B?UTd3bmk5ZCt4Nk9lYzZ6c05rRUJQcU51WUs5REVoWGQvYzYva1ozZ016UWRt?=
 =?utf-8?B?eEVmK1M3S0ZzRmlWNTlJVzRKVFNsc1dWNUJBbytIZUltQmFBVHdMcDNGeDFh?=
 =?utf-8?B?VS9FNDBia2JtUHV5OHJ1ZWFaMFljMXBnNDA2L1JOMlJpMlhPcjFFY2NsV2pN?=
 =?utf-8?B?OXVMMlhidk5SQkZROXdTcG1OUEZsamtQVys1dW0vazkrT3BhK1NwclRvc3gv?=
 =?utf-8?Q?EASKEBnlJue62/BGSlTAN1cUz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcdc8c7-d872-4363-0cd0-08db0b128834
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 02:57:22.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5Fz3kPLjCDVjp0FB1f2ws6nofR3wJEYZAX1ApiTe/HGuz4UH/mfMnS+Ii3WKLrTbBQuPis2sEt7ed/GRHHeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBNb2hhbW1lZCBHYW1hbCA8bWdhbWFsQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBGZWJydWFyeSA5LCAyMDIzIDE6NDggQU0NCj4gIC4uLg0KPiA+IFdlIHNhdyB0aGlzIHdo
ZW4gdHJpZ2dlcmluZyBhIGNyYXNoIHdpdGgga2R1bXAgZW5hYmxlZCB3aXRoDQo+ID4gZWNobyAn
YycgPiAvcHJvYy9zeXNycS10cmlnZ2VyDQo+ID4NCj4gPiBXaGVuIHRoZSBuZXcga2VybmVsIGJv
b3RzLCB3ZSBzZWUgdGhpcyBzdGFjayB0cmFjZToNCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlscy4g
S2R1bXAgaXMgc3BlY2lhbCBpbiB0aGF0IHRoZSAnb2xkJyBWTUJ1cw0KY2hhbm5lbHMgbWlnaHQg
c3RpbGwgYmUgYWN0aXZlIChmcm9tIHRoZSBob3N0J3MgcGVyc3BlY3RpdmUpLA0Kd2hlbiB0aGUg
bmV3IGtlcm5lbCBzdGFydHMgdG8gcnVuLg0KDQpVcG9uIGNyYXNoLCBMaW51eCBzZW5kcyBhIENI
QU5ORUxNU0dfVU5MT0FEIG1lc3NnZSB0byB0aGUgaG9zdCwNCmFuZCB0aGUgaG9zdCBpcyBzdXBw
b3NlZCB0byBxdWllc2NlL3Jlc2V0IHRoZSBWTUJ1cyBkZXZpY2VzLCBzbw0Kbm9ybWFsbHkgd2Ug
c2hvdWxkIG5vdCBzZWUgYSBjcmFzaCBpbiByZWxpZDJjaGFubmVsKCkuDQoNCj4gPiBbICAgMjEu
OTA2Njc5XSBIYXJkd2FyZSBuYW1lOiBNaWNyb3NvZnQgQ29ycG9yYXRpb24gVmlydHVhbA0KPiA+
IE1hY2hpbmUvVmlydHVhbCBNYWNoaW5lLCBCSU9TIDA5MDAwNyAgMDUvMTgvMjAxOA0KDQpJIGd1
ZXNzIHlvdSBzZWUgdGhlIGNyYXNoIGJlY2F1c2UgeW91J3JlIHJ1bm5pbmcgYW4gb2xkIEh5cGVy
LVYsDQpwcm9iYWJseSBXaW5kb3dzIFNlcnZlciAyMDE2IG9yIDIwMTksIHdoaWNoIG1heSBiZSB1
bmFibGUgdG8NCnJlbGlhYmx5IGhhbmRsZSB0aGUgZ3Vlc3QncyBDSEFOTkVMTVNHX1VOTE9BRCBt
ZXNzZ2UuDQoNCkNhbiB5b3UgcGxlYXNlIG1lbnRpb24ga2R1bXAgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlPw0KDQpCVFcsIHJlZ2FyZGluZyAiYmVmb3JlIHZtYnVzX2Nvbm5lY3QoKSBpcyBjYWxsZWQg
IiwgSU1PIGl0DQpzaG91bGQgYmUgImJlZm9yZSB2bWJ1c19jb25uZWN0KCkgaXMgY2FsbGVkIG9y
IGJlZm9yZSBpdCBmaW5pc2hlcyIuIA0K

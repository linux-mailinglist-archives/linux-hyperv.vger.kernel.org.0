Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6D5BD413
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Sep 2022 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiISRvO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Sep 2022 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiISRvA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 13:51:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013000.outbound.protection.outlook.com [52.101.64.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCD43637;
        Mon, 19 Sep 2022 10:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjPPfDmzQaSYPFu+IPNjKLWpQ90JqiPUMGsd5+IxpdnBs7wpKEkdQ4uyKupoX2wAzXX5unAVna8TO+tY43CFam+OpQNVg8z9vP2SsWWz9pKwxE0NHSJ+FKfPLIC00BYTb8iUsDpQlPS2o54z4xoDflXEzxJFd7O84aBBXlM0w3YEHgqBV2IP3nPsg/qSWI/aaHS8iCuNINMpjlS/pvQ2Y92KFSGiuPSDLekCKtI+5vbdBF26XlwQXeR01Ng8i5ZauFZjuEskOzAqvcBmsFIoCKXcyPGtOocVxwiQ3idhXOOv2rjBSnuz932Q7O4EVN3/GNBgGLOStlvdqZltEn32AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Guwn9BPYBi0DMRvQnNylyK0zbC14dgMeeKTOr2LYBDs=;
 b=bD8iFAMw5UAmURqtgryQwF/TYtHcT7FEU1V3JxsWNySSz+xZBLVJpf2HKuGnqqdzC1h5eDdl4SVL8E6Jh0MxRMzuq15KiWzqS9Yc2gbiOCnpBcjHvsY/gXJYRWMxZoIqZYD9Rro2b0R8Q+lzDELdPGIe9h7r16pIZNLy9sl7GTAQz6Eofqb8+NbDBSFjDdVrD2DO5uTCTZzDqQTIDhuudN8ckl2SjiDgmBMlQPaHC9Au3rf0r/R9f26gvfB2kul6PBXS22ANRmZf1CEqLe/Bb1RlUcEOKJmtH6VDn0wdlwD6rmDpKqNAj8UtHwEFLN507gaUJzfoU5jzUdEBekabwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Guwn9BPYBi0DMRvQnNylyK0zbC14dgMeeKTOr2LYBDs=;
 b=wE6LzQfHRa46ejG5urwDoFeezkyCO5YcDSiZzwgEteuh7wIxlOIulpeTabSkKnGLm/tg7yy79yVcLsInyrgJa1DksyCYSKF10wrPwRLpoiH3Q+KiusauvzaqMqqh733iVR1RYp9PFC3wI/KWX4fABUolv1N/eZ2Zyd86rmnahH4=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BL0PR05MB4753.namprd05.prod.outlook.com (2603:10b6:208:2b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7; Mon, 19 Sep
 2022 17:50:52 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::ae59:5c22:5ddd:bec8]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::ae59:5c22:5ddd:bec8%8]) with mapi id 15.20.5654.014; Mon, 19 Sep 2022
 17:50:52 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     "agraf@csgraf.de" <agraf@csgraf.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Ashwin Dayanand Kamat <kashwindayan@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Nadav Amit <namit@vmware.com>, Alexander Graf <graf@amazon.com>
Subject: Follow up questions on LPC 2022: MC: Instant Detection of Virtual
 Devices
Thread-Topic: Follow up questions on LPC 2022: MC: Instant Detection of
 Virtual Devices
Thread-Index: AQHYzFBcbSAAH/YmmEyYkV+Wg4d3pA==
Date:   Mon, 19 Sep 2022 17:50:52 +0000
Message-ID: <6AA2CAD2-C799-46A0-907C-03BB802C4FA1@vmware.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BL0PR05MB4753:EE_
x-ms-office365-filtering-correlation-id: 2b62d97e-5e3b-412d-9b4d-08da9a677edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTOP+q8pzkkVq1iqtwD6QuKBXmWz0qXN9/lTyCmpcBMGGTgbATJNTMD7yhrXmE8LgU9xRTy0ps0MDc7p6ZLvad2Yh3YQ9K/P5XRe1jrjl5tqjIEfG1qHhW6L3UA/opYtBwBVl5xph0cnrbfYtqrPXCme1uLHQo7raeTKpl6uy/d4kS7GSZfPAprGZccH6Wdt3ZZRYOdqwg/mxkzlY4GMuGZesjeLjbBqzaNMDNnlqlRPBBdb3tYkUilqcKMlCWOsBF0pgXdxEaT2MHDqPkEo+ivxW9sEG6N237t/iqxvJLqq5+QIsPbHdKds2AfS4munujpvYTAMLUJHPYvbAURiVpotcqSF807BLrYEoewgg7wC1EKIDSlzP1dZczHayDBO/W6vUiSvi5PQqv/Nqib1wJxziDuVORVP24IQTP/NT94piCnunub1QhBiWSX25dmyhuD3NiMsfxlkZJroHvqOaTIn+u4vQjSVzZgjdwgBHyoGtcHgvGIXZ7xARMQSewBB/ToFVzunSsHgIig6lfpVaP70h1lR5Wnb2xRLQa8W1lCVxU+90WYW2ko1AqCklAxyK4Uoo+x+tCfISgsWEOS7WnXjWOyklkVOoIZVctMbRGGT7ijv57/tPuvxKspHB8ordH5eClhvhZ5asDVBrUjDTM6Hx+TUHxutpR8v4rb+wKkVfZnSPtjtEl6C+3o0ybACtJkeXPSgUWc2dEV+/bF+Yd+yAHvbSAk92YNmeyJoQgbJJMeB5YqmeU98aicToL6OVFeRzzadYJsELuFswEyKB79l/vAvktbMIDHXyqz3gRBcV7MwLzBRvrFNcbgTcQYyingP/UimyydxcrmWT/KGKKYqcHa31xWd5O5vpYIde3m5Ode9CFXs8SmZ+jqoc4GI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(110136005)(478600001)(6486002)(71200400001)(4326008)(316002)(76116006)(86362001)(33656002)(54906003)(5660300002)(91956017)(66446008)(41300700001)(8676002)(66556008)(64756008)(66946007)(66476007)(38100700002)(8936002)(186003)(83380400001)(6512007)(26005)(966005)(122000001)(6506007)(38070700005)(2616005)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0xYd1UvU0c0NzZGWmpWUEZ5Qmg3RHdoQ0liemdmbU9OTGpwWGpoSDRmYmo5?=
 =?utf-8?B?UUh2bWxSbll6bU0wL0QzSURoYmZvbWxrZ0RUMjhEWEJwejh1Q2RVcnRjOHlp?=
 =?utf-8?B?ejg1SHhIVXd0REZHMnRDUndTQmJ4TXNIY20wQnZwZ1orZGRzdHgrZndmL05l?=
 =?utf-8?B?Wm9vaWt0NHBWbURWNTFCeEtEL3BTNzFJWktjWEJJdEhGWlBoZ0h2RHZHWUg0?=
 =?utf-8?B?Ykl5QUM0SERQZlgwL0VXSjVSdENNaGd3RmUzNis5Z3NwMDVtOGZuMVowNEhG?=
 =?utf-8?B?YmpEam9sd1AzYjhlMDlwOGM4eXNNTnFRY0xsZThReGt6TjBUejRKMm96MGZB?=
 =?utf-8?B?cklzclIyMG5FYUIzb3doazlpZVpKSGt1VzlpMHNPUzJreUl3SkUrMThZYWFx?=
 =?utf-8?B?a1dLb1lqZVBWMGNBQzZacEdjTUNTY0ovT2Fia3dUeVFsaFQ2SFlOUWxFdGVx?=
 =?utf-8?B?V3UxZktrcWwvMFZsbFlPU1Y5V0d5Y1Vyc0o1V2xscmQvQXY1ekFTN3FSWHQ5?=
 =?utf-8?B?MmlwYWVOQTBwazE2dmVqMWdrNFk2a2J2TVE1ZzFqdVlEejhpSUhyTFJPbi9F?=
 =?utf-8?B?SU93Tzc3K0lnUXljTFFndlhyaVlaZkFtVHVQbFpIaHlHdjlaVm90cERsTktE?=
 =?utf-8?B?S1FpQlBXYWtJdktvdEVpbEg1eXBpQ2NVV3NDYXJ0TnhJY1R4L2pXUmN1Z2Qy?=
 =?utf-8?B?dmxrdmJnUVFWYVBseGtVZ1lJOG84NXdtRlVCeVNMRnRpQ2NWN2hwWWJmWmNE?=
 =?utf-8?B?SzU4dS8vNWlmaUtQZWxGVlNlQVpkZjJYbk01STZoczNKQVcrU3BXWG5CQkY3?=
 =?utf-8?B?U2QyY0Fic2tXREx6OGd5MWVxbGNCTHpKQUtoLytYaTJqSU83K3VJT0Jsd0xJ?=
 =?utf-8?B?cXpRcy9MeDhDNVMyT2lwYUdaMUt1NmtmMXBLSVpENXlaTzBCalA3K2NBd2dz?=
 =?utf-8?B?amNOenoxK0pXQytsVnkzaGxJaG5FZ2xSQ1FqcHdwQS9LRGc0Vk5wbVZrTnQ0?=
 =?utf-8?B?eFJCUjR1NU41UVBGS3U0Z1A4WnhGcnArRlFNT25tQlh1T3NyZExrUXdEQXZQ?=
 =?utf-8?B?MGVnZG1KT255RHNMMlFLVWoybmU2M2NReE5LeHdGRExFVWFCY2N4OEJaQWo4?=
 =?utf-8?B?U0dsQUxWejc1NVA2b0VVcDR6WVpBN2VTN0xsWC9EYUp2SENacEpjWEpEdU52?=
 =?utf-8?B?amF2S2VreDdKc2dGRVN2YkZ3b2dWaVU5c3NrNGQ5Y1hlQUVVRXZZcjJhVFJu?=
 =?utf-8?B?WFBXYW9xTkFzai95eEF3cTJTWnR2bTJJTEhOWmJsbTdiUzBYOGJZWGNoUy94?=
 =?utf-8?B?QkxqY3VtbGJnSWhLOHI0N2kvNmwxby9TWDJVdXJ5M0NBcnFuL2Roc21JT09O?=
 =?utf-8?B?OGQxaVdoZm5kSE1yVU8zaHlPQlU0UFIxTHZ1NThHVFlrSkNqU0s2NXpUVDQ0?=
 =?utf-8?B?S0ZPTURHS0k0MTFSS21BaVhPd01lb2l3RXBHbmx2WXl3dndUVFRLUThNeWZz?=
 =?utf-8?B?QUs1aDN0ZVhYYUkvRkJhYlFHYkorNjg5bm0xZEVBRVA3UnN5TUJvTjhIZjdy?=
 =?utf-8?B?MkFKOEoxeXEzaW5MQk5XczNDaDQvNVdLVTFMV3h1SFVySFRDMldSOWtRZjhI?=
 =?utf-8?B?dU1mTm9sZk8xc05sVkJvcDJMOXpJT2NGWjdoN1RjWHd2MVdEY2tkZS9GTXVD?=
 =?utf-8?B?VGkweHRvQi9RM2dJSkp6MGJHMFJwRi9UT04rQk96RE5PYktQV2h2WkdIYXBZ?=
 =?utf-8?B?S3huYTNrOVFRby9UaDNNTjE1MFJoZVd4ZHhRU0hPYWJWVW1mSTZIS0NSY0g2?=
 =?utf-8?B?Y3IyMXVVbTY1OHhrNEwwbjVLSE0xWVB1NVVjT2gwNDh1WitZUHRWY2ZqUzVh?=
 =?utf-8?B?SnU1OGhodE1abmROZGVCYmN4SklEVkVud0pkR1gyUnIzWVMxTC9SOW5xU3NL?=
 =?utf-8?B?R3RBLzhiVUZGNFRpYjBsN3QzWU9sREExeWR6NVlONGVmekJtQU1PdWNtclNE?=
 =?utf-8?B?d3RJYk51Q3I5Z0g2bko5SHdBYlA0d1h6M3JTa3VxMmNsQldKNzU3WjU5Zkha?=
 =?utf-8?B?TXcwcVNQcjBNUzU4ejZzTUR4STAzekFOVVZLbkZ0b3FQeXo4RDVYZlpnSmt1?=
 =?utf-8?Q?4XPSq2J5rG4LKrKyJbpLnWQ+m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <607243E31E50DE4E9D314D11D7F1FDDE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQpIaSBCam9ybiwgQWxleGFuZGVyLA0KDQpUaGFua3MgZm9yIGF0dGVuZGluZyBhbmQgcmFpc2lu
ZyBxdWVzdGlvbiBkdXJpbmcgb3VyIHRhbGsgb24gIkluc3RhbnQgRGV0ZWN0aW9uIG9mIFZpcnR1
YWwgRGV2aWNlcyIuDQpSZWNvZGluZyBsaW5rIGZvciByZWZlcmVuY2U6IGh0dHBzOi8veW91dHUu
YmUvMG1JTzU0b1Eyekk/dD03MTUxDQoNCg0KQmpvcm4sIEkgaG9wZSBJIHVuZGVyc3Rvb2QgeW91
ciBxdWVzdGlvbnMgcHJvcGVybHkgYW5kIHJlcGxpZWQuIElmIHNvbWUgZG91YnRzIHBsZWFzZSBs
ZXQgdXMga25vdy4NCg0KQWxleGFuZGVyLCB5b3Ugd2FudGVkIHRvIGtub3cgYWJvdXQgZm9sbG93
aW5nIChwbGVhc2UgY29ycmVjdCBpZiB3ZSB1bmRlcnN0b29kIHNvbWV0aGluZyB3cm9uZyk6DQpX
aHkgd2Ugc3RpbGwgaGF2ZSB+MzAwIHJlYWQvd3JpdGUsIGV2ZW4gYWZ0ZXIgaGF2aW5nIGZvbGxv
d2luZyBwcm9ncmVzc2l2ZSBhcHByb2FjaGVzOg0KLSBNTUlPIERpcmVjdCBSZWFkDQotIFNraXAg
d3JpdGUgdG8gUENJZSBjb25maWdzDQotIFByZS1jb25maWcgb2YgUENJZSBjb25maWdzDQoNClsx
XSByZW1haW5pbmcgd3JpdGVzOg0KQXMgcGVyIFBDSSBzcGVjaWZpY2F0aW9uLCBuZWVkcyB0byBw
ZXJmb3JtIGZvbGxvd2luZyBvcGVyYXRpb24gdG8gcmVhZCBCQVIgYWRkciBhbmQgc2l6ZToNCi0g
UmVhZCBjdXJyZW50IHZhbHVlIGZyb20gQkFSDQotIFdyaXRlIGFsbC1vbmVzIHRvIEJBUg0KLSBS
ZWFkIG5ldyB2YWx1ZSBmcm9tIEJBUg0KLSBXcml0ZSBvcmlnaW5hbCB2YWx1ZSBiYWNrIHRvIEJB
Ug0KDQpTYW1lIGFwcGxpZXMgdG8gZm9sbG93aW5nIGNvbmZpZ3MgYXMgd2VsbDogDQotIEJBUnMN
Ci0gSS9PIEJhc2UvTGltaXQNCi0gTWVtb3J5IEJhc2UvTGltaXQNCi0gUHJlZmV0Y2hhYmxlIE1l
bW9yeSBCYXNlL0xpbWl0DQotIFByZWZldGNoYWJsZSBCYXNlIExpbWl0L1VwcGVyIDMyIGJpdHMN
Ci0gSS9PIEJhc2UvTGltaXQgVXBwZXIgMTYgYml0cw0KDQpUaGVzZSB3cml0ZSBvcGVyYXRpb25z
IGNvdWxkbid0IGJlIGVsaW1pbmF0ZWQgd2l0aCBvdXIgcHJvZ3Jlc3NpdmUgYXBwcm9hY2hlcyBh
bmQgbWFqb3Igb2YgcmVtYWluaW5nIHdyaXRlcyBhcmUgYmVjYXVzZSBvZiB0aGVzZSBvcGVyYXRp
b25zLg0KDQoNClsyXSByZW1haW5pbmcgcmVhZHM6DQpCZWZvcmUgaW5pdGlhbGl6ZSBNTUlPLCBn
dWVzdCBwZXJmb3JtcyB2ZXJ5IGZldyBQQ0kgY29uZmlnIHJlYWRzIG92ZXIgUElPLiBJIGd1ZXNz
IHRoZXNlIGNhbid0IGJlIGVsaW1pbmF0ZWQuIA0KDQoNCi0tQWpheQ0KDQo=

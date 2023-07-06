Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EC74A374
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjGFRvx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFRvw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 13:51:52 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AB1994;
        Thu,  6 Jul 2023 10:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbM9enVnbYcdSatBJqe9Y6szpRHp3lr1wZstBHiB1lyWb1irzInNP5J89n9RleRONK+w0861QjbPnkJ8so6VAcn3AYojS6b6aeP783M/XSz2405jCQb6VC2mU4BcyXuLR6T+nBYuEP+LqSFZDc6E/ZX5+/a0U0qpair15asWViJJIf63o88YtEWlJUi/bYttr92yvx+GYpMxnKgkPj8h+QJOwEhRTJrbYBPz7B8cuMmeKPUOKBRLE6BjxWDX477qKTt2mhj6t+Qg8MAmR/rZtuyvH9me4u3ztVkO7xb5Cue5QTfYF4iwsSCxyqAwADLR6IjxFbIWRSwvehQhLuMIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oUKq3Of+Hhd5swXWsIf4EBR2YGAnTH+F5w6F10KzhI=;
 b=Bp43YxonXqZp3rEiKB4k7tx6HUWgdmJRrFg65b52Q40HydRyMcx0LN6TGNBXoV8rsHtg2ps+CbHWT2pgg9wEBVUTbtJdhoIi9qMH0wFSYcVg/pByd2YVd3+Gy/vCWoH69kRGKVVjvzGZbolkBwJ4R6XsrNRzyOKVBj4PFASoFjntwYXmrg+Zs42BK1kDZE49/ImKPL38tthAN/92fBZ9bS/BWF5cEIP9aDCYEH2XNsJeXVRoZQwjMIRwWu4owm0cx2P7UIHTxxc5ZYpr2x9rt8ThXwZqBM9zGEL7rBcjoAGNkidzyYOox6g9p/dfi/S3fxzWoA0ta+Wf7A+ZFThoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oUKq3Of+Hhd5swXWsIf4EBR2YGAnTH+F5w6F10KzhI=;
 b=QhRG52yqLBddv60PTavf5g9nGi1Gmb+cj51xuXxiJoS6EeY2NrKJEqsjnucgNN1IiUfy6M30BFbOhX6Z49L/WAN78U65s2SNop7PxKVjHIVm/SS4C69HAg2WJE45+1l8BwHYOKL1wTPVyOKFp+Gw7/UvTo6zQ9UDtVfDQdxB8SY=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DS7PR21MB3573.namprd21.prod.outlook.com (2603:10b6:8:92::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.11; Thu, 6 Jul
 2023 17:51:47 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Thu, 6 Jul 2023
 17:51:47 +0000
From:   Long Li <longli@microsoft.com>
To:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgACaBvCAARhFAIAAZi9AgAAzZwCAAA42kIAAMnKAgALheSCAAPUJgIAFNorA
Date:   Thu, 6 Jul 2023 17:51:47 +0000
Message-ID: <PH7PR21MB3263FF8D807D917814DDEBF4CE2CA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
         <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
         <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
         <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
         <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
         <2023063001-agenda-spent-83c6@gregkh>
         <PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
         <20230630163805.79c0bdf5@kernel.org>
         <PH7PR21MB3263ED62B45BF78370350AD7CE28A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <8fb0c81c022d58d3f08082764038d17cfc849ba1.camel@redhat.com>
In-Reply-To: <8fb0c81c022d58d3f08082764038d17cfc849ba1.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5f94fca1-4708-4256-be54-73af7837fb6c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T17:51:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DS7PR21MB3573:EE_
x-ms-office365-filtering-correlation-id: 17f4933a-92b3-454f-f643-08db7e49ab1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDi+9lu8H+rzU1b9UY502qrXLnX0pMhB9yYtyhIPtxjcFvDkM2v349d9qztMtjMs2MaUPth+yu26tRbf8MRNBMKVyJElODzpFrSU+LzKsvtDjNbNDfpJQsekjbi1kAMaoEvXJjNJqPrTe9yNxqfyih8WZO5PEikl3JyoAdpldXDlaJrTg5sQV8nZDDVz3LCIW2rxoPRYSKOXMd/NUOXw87wDr8IgfFwQFf03wzfpEcsPdIi2jVwEt4xGKrO20MbFbjESAWtCErmlDbjgOUjC2aOUnq7E+EhPJYgcB+mwbJrlsBHKuqYTnDTY0PKBGtC/Uo3dAfxGJNf/OvQy203DJpAc6jNW4J4bHrQXqRJtbLPvW4s76jlD81yaf40em5tcjonpMV3KMQPt8FId4E54P2Fn8+NtLIK8Li8GvS+QIbINnMk8nGKobFROebrQSQopAk4eds9xSwUk3E3Hi2H7Y4KWXEQwlV5sUt2JQEm4paTEByMu1iuIDu72Y8HQWlG6vOkfCLsyPA4lKxc8jnU5zfdT+6CFEh1B+nQN4iyNlBjOe8LuLaUVKEUivAWw3tnpofAwcsnJjMVNkxknf0db4O604z6oc16RY4MO6Pt8JM+z6qINIaHHgoz1Q3gtwEcK+thxpunsq6TZ7Gz7A778OQdLo+0SHunT9VtlEkUjUTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(7416002)(41300700001)(52536014)(5660300002)(2906002)(8676002)(8936002)(316002)(55016003)(66446008)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(38100700002)(86362001)(38070700005)(71200400001)(8990500004)(478600001)(7696005)(33656002)(122000001)(10290500003)(9686003)(6506007)(83380400001)(26005)(82960400001)(82950400001)(110136005)(54906003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MCt0dlVMeVFxam1mY1ZYbGpiV2FYRGxQeURLVnJqaXBnZElabk1EY05ldS9l?=
 =?utf-8?B?a3FFaUJXbVY5dUNmTGpkRUNvelVMejVWQTF6OUFZMkdqSHV5aTl6QWNncFha?=
 =?utf-8?B?SGxDdzU4Y01TRkxtZHFCaitZSHoraUNrQWRZejJTQjVGWlBmQk5seFpiSm16?=
 =?utf-8?B?Zzd2TDBpM3kxWTJ2NjBhNWdpQ3FOMW90ZFhqelJIbzhKMk9ZTkNHNDl4WVpR?=
 =?utf-8?B?R3NVdUQ2TUl6NlJtN0xYSmRiazBadE84MkphSGNKdUpUOU5JSlZvdEo3d201?=
 =?utf-8?B?d3JOUG5KTlZUUUVaMHFUcUtQOGlPdy90RjhxRHRMckxYRnFMak9qWnJBRTVU?=
 =?utf-8?B?WVBkMDJZZEJjMWU3U0NXSWJnWTFaTEs0V1pTazNMWkJDYlVXL05Gdk5GdUJr?=
 =?utf-8?B?WmRyWWpMQjIrbElxQ01XWGhLaVhiV0I5Rm8yUWZZZ1JJb0dDQVVhdko2bzFz?=
 =?utf-8?B?QVNCYjAwTXdJNjhsMXhhYTNtcE1pOWNmR0sxM2pkTk9ncDRhR1ZCVFI1QWpq?=
 =?utf-8?B?eno4QS9YcWR4OXZTa085N0xYUGhVYTRWejA5U0V4cFJCNnRTb28rYm9yeU9O?=
 =?utf-8?B?ZHp4a0xsK2RsckRMM1AydE9WTmZ1a2traHhtWXI5ZENOdW5qVUpONHp4Qldu?=
 =?utf-8?B?aVZUTkhKbEEzSDhVL0oxelRYRUNDazd4SjVPOE96TzJSWE12aTJKbWJPdW9n?=
 =?utf-8?B?bksyK05XSDUvUnYxSCt6UDlVajRlaWJlNXdUMzlYU1JUcDh1TFVSTUZOQVZN?=
 =?utf-8?B?cFNNZEcxeVg1R1BhR0tFWEhPdW55Ukp1VzZ2R1JtQWZsc1RXTVNXU3A5UDBM?=
 =?utf-8?B?TW93SHBrRGw1bVpSbVUzdUlQZE4rOHpwUDNydUpERlhnckdZeUNNU0IzckNk?=
 =?utf-8?B?QlRLZVp4SGd3Q2kyU016R0I2TGYva0RJS1djRHlpcVlJdnZUZWdkWHhvNGQy?=
 =?utf-8?B?dnpYWlpBOWhRQkFrOWxRK0ZPbXpTSjlMMmFaYzNaTlhtd1ZoNjJnS05jbDZE?=
 =?utf-8?B?TlRTRUplVjFpWUZMYTFFVFoweXh3ZW1oTzFvVEYwVUJReFhRaUR1aGlrenlj?=
 =?utf-8?B?ZHlzN0JLb1IvOG5oRzVVWFFPdVFMbDV5aWpSbjFvbFNFOHcva3U3TWROK2ZL?=
 =?utf-8?B?RjJ1LzRJR0xrSkJtYkpNT2JOei9jQThzZ0U3cXp6czUyck5Uem1Ba2lTRG8x?=
 =?utf-8?B?dTdZMmVQbzJYSjlmTXVURlN1VDR1V2VtSTk4WE5JWDVxSUQxbGYxNi9TVFd6?=
 =?utf-8?B?MUVObGZTZ3ZZcSs1REE2Tk1xNXN3NHVRVDlBZHRJRE5lc21qMlhVOGRENFJC?=
 =?utf-8?B?NCtvYWVJUU9NQlQrdk8zbmRicE9Ua1NaQUhCZ0lLdVhaOGE5aEx2eUF1bGdY?=
 =?utf-8?B?ajBEeHEzbXg1QnA0TjZpSWRUaVR2VmpkNGRPMVRTTG5IaDZTYzErOVVhejM2?=
 =?utf-8?B?eEhDdzFrdVY3TnRjenk3NXJSR0MxeWFOWFR0ZjF0NFpWNlJ0Wi92YUtTQkFC?=
 =?utf-8?B?MmM0bk5GWmNEblpTZ2NYa3NibVhDMER2NXQ3MDU2QVdaV21MVEpqUHNjdVMw?=
 =?utf-8?B?bFd4VzFwMlNjTE15a09iNjl5dnZhaEVrelhyZnZ2M1d4MVIrd3VsbG1nZk5i?=
 =?utf-8?B?eGIybVJJTkxJWWdBR1R5dENoRXA1amFqZ1lkVUhHSktXemsyTWhjMWNaYWRw?=
 =?utf-8?B?K2xuUVQ4ZzA2VGxmL3M3eWJyQTlQazlYcGVvdHRXTnI1RWN5c3BUd3FPU0pm?=
 =?utf-8?B?OFB2VXBVckFIZVpWL2pqR3diaEVhRTF2V0xVMEo1V0VVRFNpaUNhcWg3TVh0?=
 =?utf-8?B?Tlh2RTJDMGpLTDc5cW9rQ1VnY1hjWTdaVkdEYkVTUDhyc3FxTEk4RE5sY3FL?=
 =?utf-8?B?SkVmaEpqWFJFRXZ1WUVvZUY2VU01UmcvbnZCd0YrVHJ1cVR6RWtUbFo5Vkkx?=
 =?utf-8?B?ZTlIZGRwMi83ZFFncWJUd3pid1VxN2k1YmFlbCtxNXJqRTdZMjJ4TWduTHZ1?=
 =?utf-8?B?bjNFWkxxZ1VMdmY4TzduNzVtUUdNcFJBOXo0dUwzNUc1T2ZKcmFVWWc4Y0kz?=
 =?utf-8?B?UWZuSm1kczhUamI3MkJBdFFobjU1TEhidzRyZk4wMmsycUFpWGlqV1ZvK0sz?=
 =?utf-8?Q?vfH7drLQgfqQWETZ3DNyRimoQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f4933a-92b3-454f-f643-08db7e49ab1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 17:51:47.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RkIcogXlaOs73CgxktfMgIjthVYiJxUubiTESUT88ata+ot3YP4DsIJTsU21bWCtcNGCXVTmWRPJY7MDnjmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzXSBuZXQ6IG1hbmE6IEJhdGNoIHJpbmdpbmcgUlggcXVl
dWUgZG9vcmJlbGwgb24gcmVjZWl2aW5nDQo+IHBhY2tldHMNCj4gDQo+IE9uIFN1biwgMjAyMy0w
Ny0wMiBhdCAyMDoxOCArMDAwMCwgTG9uZyBMaSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IFN1
YmplY3Q6IFJlOiBbUGF0Y2ggdjNdIG5ldDogbWFuYTogQmF0Y2ggcmluZ2luZyBSWA0KPiA+ID4g
PiA+ID4gPiA+ID4gcXVldWUgZG9vcmJlbGwgb24gcmVjZWl2aW5nIHBhY2tldHMNCj4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIDMwIEp1biAyMDIzIDIwOjQyOjI4
ICswMDAwIExvbmcgTGkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA1LjE1IGFuZCBrZXJuZWwgNi4xLiAodGhvc2UNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGtlcm5lbHMgYXJlIGxvbmd0ZXJtKSBUaGV5IG5lZWQNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoaXMgZml4IHRvIGFjaGll
dmUgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwZXJmb3Jt
YW5jZSB0YXJnZXQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaHkgY2FuJ3QgdGhleSBiZSB1cGdyYWRlZCB0byBn
ZXQgdGhhdA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlIHRh
cmdldCwgYW5kIGFsbCB0aGUgb3RoZXINCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBnb29kbmVzcyB0aGF0IHRob3NlIGtlcm5lbHMgaGF2ZT8gV2UNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBkb24ndCBub3JtYWxseSBiYWNrcG9ydCBuZXcgZmVhdHVyZXMsDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmlnaHQ/DQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhpcyBzaG91bGQg
YmUgY29uc2lkZXJlZCBhcyBhIGZpeCwgbm90DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGEg
bmV3IGZlYXR1cmUuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IE1BTkEgaXMgZGVzaWduZWQgdG8gYmUgMjAwR0IgZnVsbCBkdXBsZXggYXQgdGhl
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN0YXJ0LiBEdWUgdG8gbGFjayBvZiBoYXJkd2Fy
ZSB0ZXN0aW5nDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhcGFiaWxpdHkgYXQgZWFybHkg
c3RhZ2Ugb2YgdGhlIHByb2plY3QsIHdlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvdWxk
IG9ubHkgdGVzdCAxMDBHQiBmb3IgdGhlIExpbnV4IGRyaXZlci4gV2hlbg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBoYXJkd2FyZSBpcyBmdWxseSBjYXBhYmxlIG9mIHJlYWNoaW5nIGRlc2ln
bmVkDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNwZWMsIHRoaXMgYnVnIGluIHRoZSBMaW51
eCBkcml2ZXIgc2hvd3MgdXAuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4g
VGhhdCBwYXJ0IHdlIHVuZGVyc3RhbmQuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gSWYgSSB3ZXJlIHlvdSBJJ2QgdHJ5IHRvIGNvbnZpbmNlIEdyZWcgYW5kIFBhb2xvIHRo
YXQNCj4gPiA+ID4gPiA+ID4gPiA+IHRoZSBjaGFuZ2UgaXMgc21hbGwgYW5kIHNpZ25pZmljYW50
IGZvciB1c2VyIGV4cGVyaWVuY2UuDQo+ID4gPiA+ID4gPiA+ID4gPiBBbmQgYW5zd2VyIEdyZWcn
cyBxdWVzdGlvbiB3aHkgdXBncmFkaW5nIHRoZSBrZXJuZWwgcGFzdA0KPiA+ID4gPiA+ID4gPiA+
ID4gNi4xIGlzIGEgY2hhbGxlbmdlIGluIHlvdXIgZW52aXJvbm1lbnQuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IHRoaXMgcGF0Y2ggd2FzIGNv
bnNpZGVyZWQgdG8gYmUNCj4gPiA+ID4gPiBhIGZlYXR1cmUsIG5vdCBhIGJ1ZyBmaXguIEkgd2Fz
IHRyeWluZyB0byBqdXN0aWZ5IHRoYXQgdGhlDQo+ID4gPiA+ID4gIkZpeGVzOiIgdGFnIHdhcyBu
ZWVkZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGFwb2xvZ2l6ZSBmb3IgbWlzdW5kZXJzdGFu
ZGluZyB0aGlzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2l0aG91dCB0aGlzIGZpeCwgaXQncyBu
b3QgcG9zc2libGUgdG8gcnVuIGEgdHlwaWNhbCB3b3JrbG9hZA0KPiA+ID4gPiA+IGRlc2lnbmVk
IGZvciAyMDBHYiBwaHlzaWNhbCBsaW5rIHNwZWVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2Ug
c2VlIGEgbGFyZ2UgbnVtYmVyIG9mIGN1c3RvbWVycyBhbmQgTGludXggZGlzdHJpYnV0aW9ucw0K
PiA+ID4gPiA+IGNvbW1pdHRlZCBvbiA1LjE1IGFuZCA2LjEga2VybmVscy4gVGhleSBwbGFubmVk
IHRoZSBwcm9kdWN0DQo+ID4gPiA+ID4gY3ljbGVzIGFuZCBjZXJ0aWZpY2F0aW9uIHByb2Nlc3Nl
cyBhcm91bmQgdGhlc2UgbG9uZ3Rlcm0ga2VybmVsDQo+ID4gPiA+ID4gdmVyc2lvbnMuIEl0J3Mg
ZGlmZmljdWx0IGZvciB0aGVtIHRvIHVwZ3JhZGUgdG8gbmV3ZXIga2VybmVsDQo+ID4gPiA+ID4g
dmVyc2lvbnMuDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGFyZSBzb21lIG1pc3VuZGVyc3RhbmRpbmcg
V1JUIGRpc3Ryb3MgYW5kIHN0YWJsZSBrZXJuZWxzLg0KPiAoQ29tbWVyY2lhbCkgZGlzdHJvcyB3
aWxsIGJhY2twb3J0IHRoZSBwYXRjaCBhcyBuZWVkZWQsIHJlZ2FyZGxlc3Mgc3VjaCBwYXRjaA0K
PiBsYW5kaW5nIGluIHRoZSA1LjE1IHVwc3RyZWFtIHRyZWUgb3Igbm90LiBJbmRpdmlkdWFsIHVz
ZXJzIHJ1bm5pbmcgdGhlaXIgb3duDQo+IHZhbmlsbGEgNS4xNSBrZXJuZWwgY2FuJ3QgZXhwZWN0
IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGxhbmRpbmcgdGhlcmUuDQo+IA0KPiBBbGwgaW4gYWxs
IEkgZmVlbCB1bmRlY2lkZWQuIEkgd291bGQgZW5kb3JzZSB0aGlzIGNoYW5nZSBnb2luZyB0cm91
Z2ggbmV0LW5leHQNCj4gKHdpdGhvdXQgdGhlIHN0YWJsZSB0YWcpLiBJIHdvdWxkIGZlZWwgbGVz
cyB0b3JuIHdpdGggdGhpcyBjaGFuZ2UgdGFyZ2V0aW5nIC1uZXQNCj4gd2l0aG91dCB0aGUgc3Rh
YmxlIHRhZy4gVGFyZ2V0aW5nIC1uZXQgd2l0aCB0aGUgc3RhYmxlIHRhZyBzb3VuZHMgYSBiaXQg
dG9vIG11Y2ggdG8NCj4gbWUuDQo+IA0KPiBDaGVlcnMsDQo+IFBhb2xvDQoNCkknbSBzZW5kaW5n
IHRoaXMgcGF0Y2ggdG8gbmV0LW5leHQgd2l0aG91dCBzdGFibGUgdGFnLg0KDQpUaGFua3MsDQoN
CkxvbmcNCg0K

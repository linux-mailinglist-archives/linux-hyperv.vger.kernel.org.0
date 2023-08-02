Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6876C3F2
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHBELb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 00:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjHBEL3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 00:11:29 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C242102;
        Tue,  1 Aug 2023 21:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQrpHQwGll9zVW1o/85XQ7t6Ustygk8VIMKlUzjwhMEecf+hv5pDvRwWJcpfjLvFkcHPmIbjVdc+z8GQHDS2U3tDrOFTBiXA1OK1ZVuQ37q643GGgIcccxdTveNBq2Hpf+2LFUvVnLNSSdkiIJhY8Acw0GGOm6fQAnIbTCYoa+EExYZ4NIfpUCQ2FCSacgV5MftI8XW0yCSfuXF5rL6OHBZB/uLvmZ6B+h3sNJtPcUK2D/bZ/9/AnGlgJ5SDI8zI6ynmJOqjd8/gp6QgAkeWZ3NAH/wfOgng+plLHCswi5DcGELFWb+pFWMcsvw8/9Ofwhx5BLG5Ikagx+VNgXeZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ANRmj/gJrOyA56B5g3gxOWDzqGWtHSV/LdEOmtmWTg=;
 b=TQSbqvVOTihUaWOZkEqV96HXRJW1ty0unYi2p6VXki8nM/tzNvkScTaZcm8I+dFJOF5alZyfHSTl3LRDj54cisgEwsct9DdUrEwEA9otU2vqcK2OgF2aE10VZxL2KPJHzQp8hWbMUW6B+5/ehXmwAbDJLtnbIblkX1hXT2hji2LpLGlN06UA+IvBfuJKCLFV8Mvact+mGAek2K4Jr5P/DTNaTLXJi5JPowe6sB81R1LhAOdDoRfOz+rUQX52/zaUAKjXozL1O0alhG+jw01MxoAjj9i0SRWs6NGxZUyuUNTaUvBcb4PYMryElqnW6+bN7u4uMvLz45KoTowoOFxo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ANRmj/gJrOyA56B5g3gxOWDzqGWtHSV/LdEOmtmWTg=;
 b=YhNLtGijP2nQcNmdu1vvYCd82UQX6Dn2nKUMX4LaKsWCs/khCV7LabPOCfNAOp+MmmiHlD3sZRecMn7wJ4W5gPEVtURVLXKG0xpSfdderyG2OyRXiUTlZ5mmtdZgtJLXVpyMgNNzmtnWwDsxF7I7cx2UBvCdIvLAuXvS8fRsm9s=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by MW4PR21MB1906.namprd21.prod.outlook.com (2603:10b6:303:67::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 04:11:20 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%7]) with mapi id 15.20.6678.005; Wed, 2 Aug 2023
 04:11:18 +0000
From:   Ajay Sharma <sharmaajay@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
 support to mana ib driver.
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
 support to mana ib driver.
Thread-Index: AQHZxKtZTQdFop6z40Wx8WejoQRlX6/WG1OAgABKHBY=
Date:   Wed, 2 Aug 2023 04:11:18 +0000
Message-ID: <F17A4152-0715-4E73-B276-508354553413@microsoft.com>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
 <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMmZO9IPmXNEB49t@ziepe.ca>
In-Reply-To: <ZMmZO9IPmXNEB49t@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|MW4PR21MB1906:EE_
x-ms-office365-filtering-correlation-id: 6c366ac8-6cae-4dcf-2003-08db930e8595
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuIjZwREc2GyKJvd1QsaikBe9Rm8KBweoc0gPNSI17dr4DvGmPFTg7M0LdHOLqjpnBl/OF9x26rBILwhidGcvNktc2BJAMDVd+o+N5kb7HHKBi7lpQIF63s/RB1YvzZdu1EfvQ+NjYf/U/M17fC/HphDzecH9p2lRin9oqmcbACmBE7Y/l3Xj2R2CbM4u+miAjOGtGgzNBoM1rcW1JOdoG8dc7FA2D/CctFb5kYKr7uG5T/ELeBCRbq4SoTGmtSRwZjMXLtYNq3ZTiYoAaY3wlQL0ycKxCMdhBNpl+AqfUS12njy9Ghqg8cQQpvKQOCGURYdgQhI/NrybvNFjpyAZolFRpmNFxaLybiVX7+CO286vrn7JfbGlB272eHrW0KR8p1eD6d+sbJ8fuuB646Qm4BDqtR16BjGEqGFqTBhXXH6A9/4vAwPDq6clxlXk/kZDAmMppDnaffDvcsT/mOX5xCayh8nW8GfYfRiJfnhVG2jSc/wpa4nnnhBvWLFFX0FIcXdqFX871owjKpOIujtRmBN/ee4Sd6IOE7v55+pLQc1P+kmiH1lBVRT9h/Qv3e15TPh1IYCyOSSYgJ/R8ZuZjy2WNQkXMRybRVvdPM9wFfh62EgP/azyNrUK0/sTLPPKeQCfm9rTrhj8f1D37AIRm8sh2bJqmy2uIHuNbDl/qdg7MkCCPleno3vQTFw1NcgGpCSP47lDkZ3vROhVuJtgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(107886003)(66476007)(66556008)(66946007)(4326008)(6506007)(53546011)(6512007)(66446008)(10290500003)(64756008)(478600001)(76116006)(6916009)(54906003)(33656002)(36756003)(86362001)(83380400001)(2616005)(786003)(82960400001)(8676002)(71200400001)(41300700001)(7416002)(38070700005)(316002)(186003)(6486002)(8936002)(5660300002)(38100700002)(122000001)(82950400001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3YxY3dnd3hEWlRQbTdXZDJBdFppb1hLRFNzZlFNdzVnWWVuZ0cxUTRLTnRG?=
 =?utf-8?B?TEI3eGtvcWVOeTBCWFZVNWUyc1VuNmdaZnc3NFF0OXhyaWE4emJ2ekZ6YTE0?=
 =?utf-8?B?UTRBaFBmZmt6ZXdTalJtK2wrcmQ2S0ZiVDlFRDl1WitmVTlJN0U4dVdwZG9D?=
 =?utf-8?B?RjFYVTNOdWcwNFF2Wk83Y2IzNk1scXMvWWVGd05XQXVsVzJUWDVUWi9FSks4?=
 =?utf-8?B?cHBzdWhTY1RvVGQ5dmlNdXAwMjZvVEJxOW9LNkVZZCt6QnZTRTJrOG1ic2FI?=
 =?utf-8?B?S0QydDFOZ0tvZzNwVlpCYkZ4OFNNVzZwMGhPeGtYdVNOdTR2UjQ5NnF3VnVV?=
 =?utf-8?B?TkhWSVltMzVBbUpJaUw4aFhUNFN3eWlCZ1ducHlHWWRvS1NVK29MZElOMHc1?=
 =?utf-8?B?Vi9HM2lEVDBDSmhwbEp0OXcvTG5zSEFQOHV5ZGl2ZUdxc3JqUmRTNllzc040?=
 =?utf-8?B?dWwrMUVEbms3ZGd0V0Q0VGZOV0NUTGhrNU1RN1NUbHdEeURIV20vWkh1YXgz?=
 =?utf-8?B?ckF3bmxxYzFLQ0JoYkFEMVVRc2F1UUpOUER4VExHUHRZRm93b2pKZWVuUkIr?=
 =?utf-8?B?UkY4YVVKWmd3T2NDYW1vdFZnekVpZjhzbW1yNE9BeStLanFNTzdLSVBTOUUy?=
 =?utf-8?B?eU8vUFR0NUl0MnpXcDBocDVLdHZDOVgzOXFXSkxjTU0yOE50R1ozV2ZwbWFa?=
 =?utf-8?B?czhKZ0l1cHFIMHpJbmp4MnBtbWxlcndNb3llMlBGaS9VMTVaMVJBMVVEOWpI?=
 =?utf-8?B?RVo0ZUs0MmFsTXBLTkV3UGtScXljSHZyYUdDRkZWaFlNcEpLNzZWWlYvY2py?=
 =?utf-8?B?b1JZbGNCNVZFeDNvUWR2cTFiaFZIWWN4OGg3K3hobjVFQllwL3VHdlBlZDZi?=
 =?utf-8?B?bUdreDdkbEVXajhkUlVwNWVPUFRha0Q1NTJ5RDlHcmJNTUsrMlEyNjFqN1c0?=
 =?utf-8?B?UklWWkVKcS8zNllsbFNqaW5DSEVwd0VVeCt1TGNHMGlpOVhQdEkvcWljaW5Z?=
 =?utf-8?B?emd3aUZUNEZ1a0pyWHd1Wkp2MTEvdEVBcVhPbWxtR3JIak52TElBVFY4eXRl?=
 =?utf-8?B?WUpqT1J6akc1UUhDdXIzZTdUZU55WFRnZElqZGwvSi9zcDNxU1NQdzdxekNF?=
 =?utf-8?B?VkJPRHZzRnhROEJmbXVBZGtmZnFleDBkcHk5VHdlRlRzeEMvSlMwR0lhL1Fy?=
 =?utf-8?B?Z01nVDJpOHZPVDQrblozcnpPK0dnMGdWQjVxMTZiU0RxTWlTWnBwNVdFUjAy?=
 =?utf-8?B?SG9yZU5ZM013RUlFL1BPNkNIaGg5Tk1DWmF3My9OeVVLTUdwaVFOYkpNbm1y?=
 =?utf-8?B?K3NDTlZBSnNvR2JiY1VxZy9VeitrNFVUNzgrNmZ0bHFEVFYxRTdMMVFSR3ly?=
 =?utf-8?B?OFQyTzlvNGZHOU5DYkhwTk91MmRkNU5VeHREbFdYNnE3YTZYeC84REMxUGhs?=
 =?utf-8?B?UTVaZW56RXlQVVpVN2tETXJxM2VSWWRFRk0xUndHUXJRUW9vVXAyNUUzdGtW?=
 =?utf-8?B?aG84SEU3WU5zaDA4Zjh0bWxvVHJOL2hNUWcvdjh6REkvZUFnOU8weURWdXRJ?=
 =?utf-8?B?b0Y3RDkvcTMyUWxDTCtmcmVpUHJyRDZqbWlVQks1M0ZMRUNYbWpjdG84VUZI?=
 =?utf-8?B?YXpvSHl6VVprczNjMWtCaEhBN0VQejVJTVVNYnpxQ2o5V1RvczBhUFBNT203?=
 =?utf-8?B?N0kwaW5ENW9iblFHVEZENUcrSFRzTlg0TWYzMi80RHIzMjFWK0VjWjVVTHNq?=
 =?utf-8?B?cFdWRnU2WlpkdkpsSXBJUFU5ejdyb0xNdVl0d0N2dy9UUnltbENLRnBTSGR4?=
 =?utf-8?B?T0IxaDd2WVY5dHV5eG1iY2lVMk5xSzlsOVZOY2p6TDVidmIyalMvaE1qM1ZN?=
 =?utf-8?B?Qkk1VTFSelV2aVMvaVRBVFRBVGVHTDN5cU9SSUJlUjNFdUFpUDRKNllhVG9q?=
 =?utf-8?B?Skc0MDYybXV2dHo2M0lyMHVxYjIycXhpa2t5bWFvdVkvRkU2UXNwN2ZqUHZI?=
 =?utf-8?B?RkRJSzl6akljVEtkbXV3VC8reTM5Z2hNTHI5Z01Ec1ZxRnYzN2g3OWR1amJ3?=
 =?utf-8?B?eEVYTDFNUzdXdGowNGN1MEpsOGJLbENlZmhYWi93K2R2amhXSW1uK2JSelAr?=
 =?utf-8?Q?QI+ynzy0Eh9Gp6ntr411tdZSz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c366ac8-6cae-4dcf-2003-08db930e8595
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 04:11:18.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIMSYO0OeFySSISXn2n/ajZ6d7mcEe3hC2KEKNgqHYJlCG5yRPRzMNJAppnR4KvwpK/xhVeRKXV3h1Ce1KrFIhq2eEJ+9D7vPvfpmGCdD0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gT24gQXVnIDEsIDIwMjMsIGF0IDY6NDYgUE0sIEphc29uIEd1bnRob3JwZSA8amdnQHpp
ZXBlLmNhPiB3cm90ZToNCj4gDQo+IO+7v09uIFR1ZSwgQXVnIDAxLCAyMDIzIGF0IDA3OjA2OjU3
UE0gKzAwMDAsIExvbmcgTGkgd3JvdGU6DQo+IA0KPj4gVGhlIGRyaXZlciBpbnRlcnJ1cHQgY29k
ZSBsaW1pdHMgdGhlIENQVSBwcm9jZXNzaW5nIHRpbWUgb2YgZWFjaCBFUQ0KPj4gYnkgcmVhZGlu
ZyBhIHNtYWxsIGJhdGNoIG9mIEVRRXMgaW4gdGhpcyBpbnRlcnJ1cHQuIEl0IGd1YXJhbnRlZXMN
Cj4+IGFsbCB0aGUgRVFzIGFyZSBjaGVja2VkIG9uIHRoaXMgQ1BVLCBhbmQgbGltaXRzIHRoZSBp
bnRlcnJ1cHQNCj4+IHByb2Nlc3NpbmcgdGltZSBmb3IgYW55IGdpdmVuIEVRLiBJbiB0aGlzIHdh
eSwgYSBiYWQgRVEgKHdoaWNoIGlzDQo+PiBzdG9ybWVkIGJ5IGEgYmFkIHVzZXIgZG9pbmcgdW5y
ZWFzb25hYmxlIHJlLWFybWluZyBvbiB0aGUgQ1EpIGNhbid0DQo+PiBzdG9ybSBvdGhlciBFUXMg
b24gdGhpcyBDUFUuDQo+IA0KPiBPZiBjb3Vyc2UgaXQgY2FuLCB0aGUgYmFkIHVzZSBqdXN0IGNy
ZWF0ZXMgYSBtaWxsaW9uIEVRcyBhbmQgcHVzaGVzIGENCj4gYml0IG9mIHdvcmsgdGhyb3VnaCB0
aGVtIGNvbnN0YW50bHkuIEhvdyBpcyB0aGF0IHJlYWxseSBhbnkgZGlmZmVyZW50DQo+IGZyb20g
cHVzaGluZyBtb3JlIEVRRXMgaW50byBhIHNpbmdsZSBFUT8NCj4gDQo+IEFuZCBob3cgZG9lcyB5
b3VyIEVRIG11bHRpcGxleGluZyB3b3JrIGFueWhvdz8gRG8geW91IHBvbGwgZXZlcnkgRVEgb24N
Cj4gZXZlcnkgaW50ZXJydXB0PyBUaGF0IGl0c2VsZiBpcyBhIERPUyB2ZWN0b3IuDQo+IA0KPiBK
YXNvbg0KDQpVc2VyIGRvZXMgbm90IGNyZWF0ZSBlcXMgZGlyZWN0bHkgLiBFUSBjcmVhdGlvbiBp
cyBieSBwcm9kdWN0IG9mIG9wZW5pbmcgZGV2aWNlIGllIGFsbG9jYXRpbmcgY29udGV4dC4gSSBh
bSBub3Qgc3VyZSBpZiB0aGUgc2FtZSBwcm9jZXNzIGlzIGFsbG93ZWQgdG8gb3BlbiBkZXZpY2Ug
bXVsdGlwbGUgdGltZXMgLSBtdXN0IGJlIHNvbWUga2luZCBvZiBsb2NrIGltcGxlbWVudGVkLiBT
byBtaWxsaW9uIGVxcyBhcmUgcHJvYmFibHkgZmFyIGZldGNoZWQgLg0KQXMgZm9yIGhvdyB0aGUg
ZXEgc2VydmljaW5nIGlzIGRvbmUgLSBvbmx5IHRob3NlIGVx4oCZcyBmb3Igd2hpY2ggdGhlIGlu
dGVycnVwdCBpcyByYWlzZWQgYXJlIGNoZWNrZWQuIEFuZCBlYWNoIGVxIGlzIHRpZWQgb25seSBv
bmNlIGFuZCBvbmx5IHRvIGEgc2luZ2xlIGludGVycnVwdC4gDQoNCkFqYXk=

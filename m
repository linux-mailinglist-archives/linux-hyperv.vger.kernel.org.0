Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9386D7471
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDEGfP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 02:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjDEGfO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 02:35:14 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021019.outbound.protection.outlook.com [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E673C30FF;
        Tue,  4 Apr 2023 23:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USBlyGF9L2OVDmasXF5Rr42/7povTB5YvoGSMT9cSxlT+K95Vp/x0EiIWFVno7l+PSFwYWWp+8JWQ5SM8cQHF4Hus7Mk/HNiCJsAKtOAH+UvGVr+HFxdEfHNO60hXuXbpfO19gzL5J5TQQg8uQiwmUE/496oDEnqh2aH5iZSF9ybOycxnnPufzGtSWSV1vMqHS1+vCSPydcB/pzNRL+S+zk2rK+6fvdy4XMmywlUar5SKxGMl58FhfhI7n0fIctEMv575FtLSTbykln8QVQO61eEFogVI9wnMYqK1OJ8/RNBMSQPZ4fmfbPuvcUwS2/NSxBbEmQbGbtS5dO1WDtZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9okYGVeaMPU+ZZuUofZ4nPcJNFM73uYCUZEQH8z6K4=;
 b=Y0qiav2ifHjusRpTYpLBUGfzaeHSSv3FvoqUq87LHBSRmjY2QET2T6YoCrNMBeKl0eyKURRpySUoOAIY7csmfsdG467wGZ+K+8OBo7BgE4OJ6VtC1wCh+SD0lCGoUb7MXNp+3a8mrUmI64C9v4j9/9Hj25/lz9i3WuLKDSnmtgjZLg6z2oy/Wk76ghk9Eswhjy/XE9eEnrUPnoTJzyRnJMAK1RqhPg7QDIR0np4EJx3NN1oNntPJob+taWZFwDqlJpPYbs+HqG+17gqdMe9gnWl4sS1pTOMZtSzkVtRGGksh64qjUG3wz479xW+I5l0M5fFWk2CFnAXzLs9u7GR5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9okYGVeaMPU+ZZuUofZ4nPcJNFM73uYCUZEQH8z6K4=;
 b=VYHNdDdcTqHdBTOVB3WRT1w8DyThfMyq8MnvKaA6/HuSQq6V82tFmDcDK6GCcyl0g3I/ERnULSzh4FI2TX4pp99Dn4DsnV+vFK3GP0VdalRBHEjCe10mkJTVs0x06qw4G3cgPfNiuzSiFKCS0AgJFI3rKsqhgiOcW7HsJx/cWIo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3409.namprd21.prod.outlook.com (2603:10b6:a03:453::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.13; Wed, 5 Apr
 2023 06:34:56 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6298.014; Wed, 5 Apr 2023
 06:34:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Kelsey Steele <kelseysteele@linux.microsoft.com>
Subject: RE: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Topic: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Index: AQHZZy9yhTeXGQzb+UuJvAtlASQcDK8blAYAgACPDoCAAAMzcIAAEHvIgAACA6CAAAKKgIAABxSg
Date:   Wed, 5 Apr 2023 06:34:56 +0000
Message-ID: <SA1PR21MB133522DEA9F9DCE47B7E7B2DBF909@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
        <20230405064019.6258ebb3@meshulam.tesarici.cz>
        <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230405072801.05bb94ef@meshulam.tesarici.cz>
        <20230405075034.3c36bb77@meshulam.tesarici.cz>
        <SA1PR21MB1335CF4B7E9B1EC61B84AA03BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230405080703.61c6d60a@meshulam.tesarici.cz>
In-Reply-To: <20230405080703.61c6d60a@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8a769642-2ed2-44e4-bc05-3149d237b4db;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-05T06:32:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3409:EE_
x-ms-office365-filtering-correlation-id: d68d4d91-c703-4d15-0e54-08db359fdf49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: to4ZyEZzjg+q9IJaiiNgFSLf9/zQOvRO1xP6TaoiavbO63SLruUubqL2lVIx9Vcd557Dn5KU6WeSv4Tx5KiC8+HLGDTplnrH9m5HXBdl+LPiEPvbsOC1kmjDiFARq31M6V6sAiJ8sIiwoZiwVPVGB70UujuLZ2lPznNk3znTgrz4RHJ+vM59d35EuyvToq/wzYndrwhx8D8QukHOnIjJUdmMehvqjTsgSa3YUZsqzsKh/4+OeTMm1SSX9t89qpcggTOeKyYiIGPLjbmfaqb1NETnjJzvBaRacqR+IhwbsNzraQCpKlFPE91QNFuaxms41a9J3lhyhmC0ftcYctzM4Ta8rXl9VY0WYpEttPOdPkH4sbg/z38UTym6ooal05WsyxDX82k/otSP9sF08gw/F06xSW+15UpcOjPhqOdJFcQXa0xFToIM3mcusdcs8dexT0+4rr8JAMIy7n2Uw9Qy0SUSI/5HrBG+eKbCA1SZpsR+HIui0IeBV8M6iUazf6FzdnQd5d62b5rRiqx18v8lE7JXRrA4P1sJsaBY6wuCsPhwvDnAtjZWLicw7D7F68nbrd/HWSgES4dqy0CALiMrZ6PG0pxZ3DrqjoPF0ZwsXILJpi7iotorze4TE3VHPwiD0XPqniFkWOwGQVmPWwR6aLxfKQj7u+OWIeS8zB/OnYs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(558084003)(54906003)(107886003)(76116006)(66556008)(66476007)(66446008)(8676002)(66946007)(4326008)(83380400001)(33656002)(64756008)(6916009)(9686003)(26005)(786003)(316002)(10290500003)(82960400001)(82950400001)(41300700001)(122000001)(186003)(38100700002)(52536014)(7696005)(71200400001)(8936002)(2906002)(86362001)(6506007)(7416002)(5660300002)(478600001)(8990500004)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUNBcm9CaXQ4eXRPWGpTODhlbUVHVFUwRmVvVTl4NjFwaURFTzRpenpRbW16?=
 =?utf-8?B?WWRnVWQwcGtTRkc2V0tvbmk2c21QK0l5MGV0RDZMZUU0ZEJnbEI3MjloKytH?=
 =?utf-8?B?R2wyMFB2bEMzZVd6TXovMWwvZEx6cERPR2VWZExwT0dyUGlOTldLcmNlK3Y5?=
 =?utf-8?B?VTREdE1pcUJEc0c0V2NlZ1ZkM3VBcjVSeTkvTnNmVCtHdDNGZ2NTbk93RHRZ?=
 =?utf-8?B?K0NFNklHNW03d0c1dVdrRU10cWE3M0Z5RDlBbjc0dnRaMkRUUUVlR2hsS0hB?=
 =?utf-8?B?dDk2clNNbHNTcnhsRGtPS01rNlIzb2ZBOWgxMktvcVVHczZlZklmUFBrQ3ZX?=
 =?utf-8?B?SkdEQmlxOUdzWHNZaGhMSFIrVkYxUzFNVmJQbUJTMmU0RzkyWWRuVG1UVEhV?=
 =?utf-8?B?ZFEwN1R3SU9sNDlNb2tBUWp5WndmN2ZUdTJkYVh3b0thYWtwUlBRNWVLQnNr?=
 =?utf-8?B?c3VSd211bnJLMDdjamZiMlV3dERjN3laOTh5a3FFTW51b0wzRVZvaG9TOEl5?=
 =?utf-8?B?b1J2T3NOZmx5SmhWRzdtVXpVdjl1WnhabTlrQ0N1ZEhsT3VvaEwrK2xyZlZL?=
 =?utf-8?B?RDEvVXV0dllpQ1BacUZYRVJxMmtBcWFUVER0eGtPKysxaEZtVTZ4K0RvVkpV?=
 =?utf-8?B?M3g1NU01TTdJV0xsUTAxRk9ob0VYSTNLNFRvNW4zZm1JTXQrWjl4NVhTQUhW?=
 =?utf-8?B?eEVSRW1aQUZZYWFwNExyZ1Zod2RXOGZmb0kvYk5WbGpEZkx1bTFYVnFndVFo?=
 =?utf-8?B?TjE2YWd5cyt0c256WTkzZ0Z6R0hCelB3Znhab3hDYXhSazl5ZWZWMGZIS1hq?=
 =?utf-8?B?RGRaOTYybkZuK1Y5ak9wWUtId0RqK1FnVnRBNWZWK3JOcUFmV2h2QnFOMHdK?=
 =?utf-8?B?YjVtVVNYT1Q5ZjBGUkhZWWY5SGhjWW0rdkZTYkZKOWpmaEZRT001eXpGRkFx?=
 =?utf-8?B?bmJ4VjN1UTZ4cU9aVDhiajVmQXhpZEs5VkVEMlhURG1xQWFyRS8vU3djSUZn?=
 =?utf-8?B?dk1nTkNmWGJwTFd4dlY4alVCRjdQRkJ1S2NEaUZhZTZmVFdGamZDa1ZEcEJ5?=
 =?utf-8?B?S3Y0azZtMWtDQStTL05iK0c1WXNQaTVxdHMxTFQ1UGg3SS9vK05vdWtOOG9P?=
 =?utf-8?B?NDRjcXVsb2QrWDhkaSt0eGo2RnRiWDV0MGNIeUJOTkdUcFhESjJLeFNTMkRi?=
 =?utf-8?B?RmxweXVaay9wRUM4NE9TMnliSXNJWVE1MTdDazlMN0kwMmxST2Q0UU5Zakc2?=
 =?utf-8?B?VzJrbmZFM29RZkduSlZZaW55R2g1bGo0amlTbnR1ZWtMcUhNM3NlM0dmenRD?=
 =?utf-8?B?ZGY5OUtiKzFRTzNMSVloeXEybk5EL0dWVHh3RjE0Z3JoMk9sVTV0aGl2SHlB?=
 =?utf-8?B?N2FBQ0NSKzRHM2NQR0MzQ1o4ZTRvemQyRTVOblZ2NWk5b0hQcTRzVDRLa2Uy?=
 =?utf-8?B?UGxsTFpRRlh5MjU1eERFN1VSWnh2UzRWaGo3dUx4YnN0aVBFZ3JGZk1tQW9W?=
 =?utf-8?B?cmVaOUV3RUozRVpWOS9oeUYxYmlKcjlQZDd2bFBJYmttYkVRY0FOSjU4SG5R?=
 =?utf-8?B?L09ENzVFVWRUL1Y4czdiazVrSElreldIczBPelYxNTBQVTZ2bE1hWnN4V2F3?=
 =?utf-8?B?MG02WUpHcFpoTVBTUndzVDhPZFdGQlR6NFJLaDA0RWZaZGhUdXNDUUpvSzFR?=
 =?utf-8?B?eHo2ZFQzT2xaNHoyODVuTVFCbUlLenR2RzlCRGVJcWI4eEUySkk2OC8xcGZP?=
 =?utf-8?B?MjdjZlhua1Via05QYmx4ZXRzcnoreEZacHhBVksyWGhVTXdiNE5hOTNFWFVH?=
 =?utf-8?B?UFhFaTZObXJXZlRWSFRoWmN2a05acjJMK1RDT25VSFFKT2FYT29oMll4WHFB?=
 =?utf-8?B?U2VhZE45WXZrTmJmMEIzL1FSTFlmbVlaSG44V1ZVOE5IVC9mTHJwN3lIUnpY?=
 =?utf-8?B?TExoQk5tb3FpVXBFcGtJcHRvVTlISHF2djlQREtvdGlDSEo5azBoSVB2bklU?=
 =?utf-8?B?YmQzbkkyQW1GNFBGcVVyVkVCeGhzT3VMc2wvRUtpWGFGdVhhK2RJV29tZVZ4?=
 =?utf-8?B?YW1XdzdMVzd6Z3JrbzhubkdXVk5UQnZTOXdUYU85dlI1MFgrRnlyUEF2akhj?=
 =?utf-8?Q?jUmXBm9SO9b30DnHD2VQGCB9r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68d4d91-c703-4d15-0e54-08db359fdf49
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 06:34:56.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9Nxb8T+/nxKfdETHcES6y4MDs1Pzl8prNmR4iVqPrrrHIncHdZ9p5EHSvaQTEXs4PalFoB33l43f3FQQssE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3409
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBQZXRyIFRlc2HFmcOtayA8cGV0ckB0ZXNhcmljaS5jej4NCj4gU2VudDogVHVlc2Rh
eSwgQXByaWwgNCwgMjAyMyAxMTowNyBQTQ0KPiAuLi4NCj4gVGhhbmsgeW91IGZvciB0ZXN0aW5n
ISBJIHdpbGwgd3JpdGUgYSBwcm9wZXIgY29tbWl0IG1lc3NhZ2UgYW5kIHN1Ym1pdA0KPiBhIGZp
eC4gRW1iYXJhc3NpbmcuLi4gKnNpZ2gqDQo+IA0KPiBDYW4gSSBhZGQgeW91ciBUZXN0ZWQtYnk/
DQo+IA0KPiBQZXRyIFQNCg0KU3VyZS4gVGhhbmsgeW91IGZvciB0aGUgcXVpY2sgZml4IQ0KVGVz
dGVkLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0K

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E070FB98
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 May 2023 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjEXQXR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 May 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjEXQXQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 May 2023 12:23:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7062D139;
        Wed, 24 May 2023 09:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPyu8c9kMXoxiWwKet6J+RncomwP4IXFqshVdIzUDid4HMepJhBV7WDVVe0H4UZOY1LCd3gcSPtpkiVwxYF8CgA6GOBU5ds3Iq847gbZAdd2vWvM/JKGjc/0Q0cd8koe0i8CuKTBIEzU/8z8lrz+9d9YXXQhLW7QwLIdLG+XP43wHvoPLReIlfBsXqZgOX64RJ4l5Ger2+M7Nkcsf4MnZUxembmCUOXaBrlDpM/04oPKumDI46W0+iGcL4oALMSxnDkHQGTVKKdCvgCUgSrsCpGoaERd7GuqKKie5EJzaqJi/C0dkzb07mfshTSr2LBW2aluzi/G//myd9iPsz1RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FTkjaW7HdLfdIZhw/thwdfy9eJplsc7Txwo7oYYN+E=;
 b=fUEAqBo4LR71DKtIYUlesccAt3i54QTMZmB1tScLhhLJV4xFbV1paFCyqmSark0kNEgm0ZkxXeZhJXty809B2oE3HxbZcL8Yn3PHjoT9+ei9oz1SU7oGGTBOyrK7LHHCb04PIxlv1sNv8GkBa3dwy5jkpBW7SiVkHl0i5iiiQ900kCS50JIes516ogVcdq7xscnV7dsuL5925/v1eZclaJTNo4fIyZZh57d26UmzNQRiVe2E2RLC0LZuRojumYAFs6NKztWmnlTWIQ63LSvkVldS20iziojS/gw+bml0qVS1D8vfWwn3oXNn7vX5jipH8RYHF7yGActawqhml11Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FTkjaW7HdLfdIZhw/thwdfy9eJplsc7Txwo7oYYN+E=;
 b=N6s0BSZbdKoNZiqaDwh81l0O7ahQRi77v8FSePRERR92FBCjRI4mRKNruOW4GfF64336vpLzsCw+f/WP7gIXApFqMEDMYjOA+5mrCZXyD+TWt565h8N13lsslCKwZ6PpDsYyU9ZUoqB4jHPVNcKmTgRepxxBCWHSGupt0nXT8tQ=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PUZP153MB0786.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.7; Wed, 24 May 2023 16:23:03 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6455.004; Wed, 24 May 2023
 16:23:03 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Index: AQHZhBiUq424crV8z0Sj0fJkb54l069oNpQAgAF1oEA=
Date:   Wed, 24 May 2023 16:23:03 +0000
Message-ID: <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
In-Reply-To: <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9c10bbb-8710-4138-87f2-f8bb703ab180;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-24T16:10:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PUZP153MB0786:EE_
x-ms-office365-filtering-correlation-id: 84e9f326-2698-4928-1e2e-08db5c7325f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TmN0atgh46EAOF6MJcudeFlT0H/CgKsv2tLVBGagUcPHtHxWQld8ERZ4HSeNEVAed9+uAqYxYRZqJVuBFxfEteWO+5scrzR0QuODuX15zm5AofYx55FKSIO0RpYSF24bj1So+MZWxd0gjH2VcofO1/zyO4k7SPnmDm1yhZ9atHG4huDiPOFzLp1VVxMkHAOBNTAPik+mvAV9kRxZDVR6+z7AdY93L1jLsuj8oQN1bUMQ3e6RcOjN2okyg1aHkIDKEbC+5cV4PuyNitsKj+gy7afbhZ9SIYm43FZp8mKgdAoxU8ZM625g5oR6uJaT25eouyWkoc8e03Zx3Wl2/2newIWO2vPw6UK1P4GLuM8IcTz8xLuXhF1kZofAAaQsf1sTm+eZJfJdrNug+ecFQYUnEwGvtnv6mFvN2j4V6hrhEPyvma/yirQIgbkAprmED2bDyAnKdXQu33LVJ4bBjqfuWeSMNZOIfQwUdCnnrLCV/MqFVBYIe1wxLHH0kOtaPiTlaAB7rW9hffC1JOBSCQdHxfbWsTAjLcEUOGYwku9Mu5nlSFo+eTJAy3v1QQ1X5nynVoyrEANikrzCnRMKRpAdJTInQwNy7j+TMAedwxBhbrGpc1mg1s0S0L0QwYq1/O/4iN3oRS5KDfrgmoiFqgaaCR1D0m65mNhJ7IPEJqp91/FxXM80RFY1QBx4GFUw5tM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(38100700002)(41300700001)(55016003)(38070700005)(71200400001)(8990500004)(110136005)(2906002)(7416002)(7696005)(478600001)(9686003)(86362001)(53546011)(10290500003)(6506007)(8936002)(8676002)(76116006)(33656002)(186003)(52536014)(5660300002)(66946007)(83380400001)(66476007)(316002)(786003)(64756008)(122000001)(66446008)(921005)(82950400001)(66556008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmtsZ3VZcFVVc3dHOS9VUS8vanR4WGY1QUh0c2orSndTS011WkozS2tpakpV?=
 =?utf-8?B?VHhScC92Q0VlTlpaVEQxMW80Y3JITnVKakxQRFhDOGNTWldnQmZaZHVmd3Ez?=
 =?utf-8?B?ZXZLSDJTWStSeGp2ejlWajRkYTlWbkxRMnNGV1puVHV2djlVTXd0SHZTUjlu?=
 =?utf-8?B?czgxbDMwWmtSYTB6T29CM0tUcGVvRU9CUlVNckFCRzBTSkdlYnhzWDE4N1RY?=
 =?utf-8?B?eVlvVnJ2OWVNdS8wMERhNEJubUs5Z0pwNjdYWWYvWEdwNEUrZTdqL1E1TzlR?=
 =?utf-8?B?NWlRT3N1REt2aG5vVVF6a292eGpsTUg4UFNqRlE3Z1BxMGhHRFZNd3FJalNl?=
 =?utf-8?B?dnFTS2pSMnFUODdTdkFtQ0h4aG8rKytwc0hjV3ZGTWtYY21iaHRzNm8zc1Ix?=
 =?utf-8?B?UlBWRGtkenduNVVKRmpicGE3ZW5YNDBIZ3FpcG5nZFo4ZTJuMGd3RDloMVV3?=
 =?utf-8?B?VmQ2a3J4UmVtdjZYcHNsWW92TDNLY1VlRVhxZE1JM1NGWFIvRGN3V2QzOEta?=
 =?utf-8?B?Q3RJWlY3enJPUnhsOTZTYWl4dFptaEZDQkw4WDlkSU9VNGdZZDFMZE9kYTRI?=
 =?utf-8?B?U2JDdlprNTc1ZDBCa2V1eFBybTVCMjZBazdPVUN3QTBvMFczZjZ1RUpDRWw3?=
 =?utf-8?B?bkZnL3VVMlNvblh5K3IzbHFDdUw3QU10ME9FekROTWltVEVsdnZSbHQxbjZU?=
 =?utf-8?B?NjF6aGNhWDZ3bWM1bk0vY2dzQ1F3TUFZeUo2SjY1c3YweHZLa3Q0MDJacElv?=
 =?utf-8?B?SGtOUXkwU1VWRDJZTWRTZFVoRmRLSTFpZXBlNE4xSzMweXRLTlhiTllFUFR6?=
 =?utf-8?B?TXZsL1dteWhKMTBHSEdvNmp5N28xUGxRaGoyOEVFR0xiRlpwSlJNVFU3NEVj?=
 =?utf-8?B?ZE9PSEEwWm5nZ0lpdEJnTDQ1eWtKamt6WXJLU1cyOVRXUVRkVU9CVnZXTGxu?=
 =?utf-8?B?NlFmL3E1S0oyU3grdXgxTmd6TFJkNC9ZYVduOVVoa3lraFcwSVNaTnNzM1Vy?=
 =?utf-8?B?WHQxM2J2Q3VlYVJxdmsrNEtka0RSa0RtZTZIdkVmT3AyUUF6enZLd2dKd0Nn?=
 =?utf-8?B?QkZwUGxOQlhBbDUzVWJoNklFUUZYcjV3eFBhbEt2WjFCVlZtTkwrMFFUWm03?=
 =?utf-8?B?U0FPSkxBM2dVLzZwNzJGd0tGUUdwOU5kR0lscmY4OE5aRGJmWTZlcG1XMUFP?=
 =?utf-8?B?SHZjQVEvVUtDa01hUEZ0NVN2aHdic1UxZEw2Q1Q3RWJaNG43b0tJdHJtL2Zs?=
 =?utf-8?B?Q3VkL2pOMHN4Rzdha0lFUU4yY0loOWl3d1o2VDR3LzliZnc4RnNBTWQ0aXRx?=
 =?utf-8?B?Zm1DWWEzTjZzakx0eUo1MmxlY04xSi9JR2Yvb3ZqclplOFBKQm5qUVJGanpM?=
 =?utf-8?B?RkVSVDdheU8yTzNTK2xSLzZPVVBVNUkydlJDS0RXTjRVbzNVdUZCR3pxTE9C?=
 =?utf-8?B?V1Q3Zk02QmxXZW15UThSL016Y1ZhMUg2N1RJTzRCSGJSR2FhbGdhcm5kMVlD?=
 =?utf-8?B?QnFsWFRxQTVGcDRzcUJBZW1nWDZzcnlqcUJ3UmVZbFJmanFTMlFXbXFxRHBU?=
 =?utf-8?B?WEZFbFhDbmNQS2VZZXBzc2hqSkVCUzNGZk9sQU9MUW1QT3Nha3VXUHRjVDRH?=
 =?utf-8?B?cnVybm1UZ2RJWXN2UzRWSTNJem1veWdHd2djdUZxTnhVRkdUelpWamdFQ2xm?=
 =?utf-8?B?bm5RUTgvbWdzRE01clovbThwZWRwdEpPbkJsVnEzQnU4VzB0Mmlqb0tTdElt?=
 =?utf-8?B?OXVsazhSdjlXdndUVnhKRlp1Y2lPR0JBOUQxeEorL0J0cE9TaW1HN2t3WW43?=
 =?utf-8?B?OWJyOVgwbjV3Y2J2YmY0MWN1enVhekVkWlZFWng1NFcwMng2bGtjUkpTQWRx?=
 =?utf-8?B?Y1M0a2RseG9JU002YkhTc3p2VXd1aG1ia0Y0RTdhZlpGQTh1OHUydCs1aTE3?=
 =?utf-8?B?UFRDaU41TUJuL1dWbHNtNllTallqU1QyeW0wbFAzWE4yNUhRSEg5MGc3RXZO?=
 =?utf-8?B?RlQvWitmZGswSlNoV21QcEpFcDNlRXpyOXlQdmE2eFBBdTlrS09QZXViU0th?=
 =?utf-8?B?UnZCcnp4QTFzZDBKeFRKQlU4aG1jUVZkSFZIbDZNYURibG1FVk4yNWxTa3lh?=
 =?utf-8?Q?PS52SbY0/8g7m7PNm8AySRc6M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9f326-2698-4928-1e2e-08db5c7325f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:23:03.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwXw5E86b1dgfinVvab7/QCc/XrlaAvYdaUxCyqasOlwA1J0PSfO+ssHUkWycEQLJRdVD90EirhgSqfYJfbiZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0786
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDIzLCAyMDIzIDExOjIz
IFBNDQo+IFRvOiBTYXVyYWJoIFNlbmdhciA8c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tPjsg
dGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj4geDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5j
b207IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4gSGFpeWFuZyBaaGFuZyA8
aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aQ0K
PiA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgPG1pa2VsbGV5
QG1pY3Jvc29mdC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1o
eXBlcnZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBTYXVyYWJoIFNpbmdoIFNlbmdhciA8c3Nlbmdh
ckBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggMS8yXSB4
ODYvS2NvbmZpZzogQWxsb3cNCj4gQ09ORklHX1g4Nl9NUFBBUlNFIGRpc2FibGUgZm9yIE9GIHBs
YXRmb3Jtcw0KPiANCj4gT24gNS8xMS8yMyAwNzo1NCwgU2F1cmFiaCBTZW5nYXIgd3JvdGU6DQo+
ID4gWDg2X01QUEFSU0UgaXMgb25seSBzZWxlY3RhYmxlIHdoZW4gQUNQSSBpcyBlbmFibGVkLiBI
b3dldmVyLCBvbg0KPiA+IERldmljZXRyZWUgcGxhdGZvcm1zIHdoZXJlIEFDUEkgaXMgZGlzYWJs
ZWQsIGl0IGlzIGFsd2F5cyBlbmFibGVkLg0KPiA+IEFsbG93IFg4Nl9NUFBBUlNFIHRvIGJlIHNl
bGVjdGVkIGJ5IE9GIHBsYXRmb3JtcyBhcyB3ZWxsLg0KPiANCj4gSSdtIGZpbmRpbmcgdGhpcyBj
aGFuZ2Vsb2cgcmVhbGx5IGhhcmQgdG8gcmVhZC4NCj4gDQo+IEluIEtjb25maWcsIHlvdSBjYW4g
InNlbGVjdCBGT08iLiAgQnV0IGluIHRoaXMgY2hhbmdlbG9nLCBpdCBtZWFucyBzb21ldGhpbmcN
Cj4gZGlmZmVyZW50LiAgSSB0aGluayAic2VsZWN0YWJsZSIgaGVyZSBtZWFucyB0aGF0IHRoZXJl
J3MgYSB1c2VyIHByb21wdCBmb3IgdGhlDQo+IG9wdGlvbi4NCj4gDQo+IENvdWxkIHlvdSBwbGVh
c2UgcmVwaHJhc2UgdGhpcyB0byBiZSBsZXNzIGNvbmZ1c2luZz8NCg0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldy4gQ3VycmVudGx5LCBpbiB0aGUgYWJzZW5jZSBvZiBBQ1BJLCBpdCBpcyBpbXBvc3Np
YmxlIHRvDQpkaXNhYmxlIFg4Nl9NUFBBUlNFLiBJbiB0aGUgY2FzZSBvZiBBQ1BJIGJlaW5nIGVu
YWJsZWQsIG9uZSBoYXMgdGhlDQpvcHRpb24gdG8gZWl0aGVyIGVuYWJsZSBvciBkaXNhYmxlIFg4
Nl9NUEFSU0UuIE15IGludGVudGlvbiBpcyB0byBwZXJtaXQNClg4Nl9NUFBBUlNFPW4gZm9yIE9G
IHBsYXRmb3JtcyB3aGVyZSBBQ1BJPW4uIFRvIGRlc2NyaWJlIHRoZSBjYXBhYmlsaXR5DQpvZiBj
aG9vc2luZyBhbnkgZGVzaXJlZCB2YWx1ZSBmb3IgTVBQQVJTRSwgSSB1c2VkIHRoZSB0ZXJtICdz
ZWxlY3RhYmxlLicNClBlcmhhcHMgJ2NvbmZpZ3VyYWJsZScgd291bGQgYmUgYSBtb3JlIGFwcHJv
cHJpYXRlIHdvcmQgaW4gdGhpcyBjb250ZXh0Pw0KSSBjYW4gZml4IHRoaXMgYW5kIGluY2x1ZGUg
aXQgaW4gVjIuDQoNCj4gDQo+IFRoaXMgaXMgYWxzbyBvbmUgb2YgdGhvc2UgcGF0Y2hlcyB3aGVy
ZSBJIHdvbmRlcjogV2h5IGRvIF95b3VfIGNhcmUgYWJvdXQNCj4gdGhpcz8gIEFyZSB5b3UganVz
dCB0cnlpbmcgdG8gYmUgbmljZT8gIElzIHRoaXMgaW50ZW5kZWQgYXMgc29tZSBraW5kIG9mIGNs
ZWFudXA/DQoNCg0KSXQgc29sdmVzIGFuIGlzc3VlIGZvciBIeXBlci1WIFZCUyBzZXR1cCwgcGxl
YXNlIHJlZmVyIHRvIHRoZSAyLzIgb2YgdGhpcyBwYXRjaA0Kc2VyaWVzLg0KDQpSZWdhcmRzLA0K
U2F1cmFiaA0K

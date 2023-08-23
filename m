Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD4784DFD
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Aug 2023 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjHWBBA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHWBA7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 21:00:59 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C785CE3;
        Tue, 22 Aug 2023 18:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyyTw4qQG15LydeL0E2GMquvzrXLs11UZHqd2+5yMrmgoSlEPRNoUeukf2Pf2RvxJ0V3KtqKnLLyT/IBlwDmvMoCwq/JWZQNOf8Rzeou01Jdtp9FnAueLmhC284uYJFEV7oiUMc8EMkcmJccGi8ieh5YtOeIIK8ofID2bPYKhdixwU/hMPDWehRaWd/eWBoucj//RDP8jwXvldQ8BZOfR5wYN7UhRZoe1ji3iVDsQcXCLnA4+8h5kncH7PtsQe7DwhcBRWhw9Y9aTs921ui99AXTjepWAgVR6ERgHT784NxWCWl8c9UD9NbVBVi0Shm2chQAyxllOj4SO1I5kZ/k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng35rwXMfy0qh2OVz0/aGiaTbrhjxI5N+cturx1cxqE=;
 b=PUaEAEdNsj4nEHCE8OBKVxRXKj8SLvoMaTSTiEegE7V28ayHY3QvBMpg74UkpFJSxNKiF83f+lPNxzA6zDjXq2wn4K7hjbO4R8TDpaT5FzORqlS5E7Z6yuizJydQ9g90GkSK7kSmHIv1GELkt6+L4g1SO/a95VrNT8a1DCpipbIf9LInfmokqqmNjbu5VzbP2MI64MC04G+n82AeScY5gkJBlA/S9w2X6fgx8sqWQ7OwwqDV54+nMGncIR0z1tx4uH8Y/qQ85+sjEEgDJFeaLe31yb4dRQsVS7oFKThZDy837PcCb/BRIAfhWHAH28nVSQYkTEU2MorQfOOTVXlXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng35rwXMfy0qh2OVz0/aGiaTbrhjxI5N+cturx1cxqE=;
 b=cUMY9+zzEtMpvIKmCFLz8yGORYZKN7mLeVf4bXClRBH5VcheJz2Sp2cWhdchLuPya8A5ju+t7ELgq8QH/RFm4DoIEESG5Whb/ALV3mMmcWXE3ELKCYpDJhDlFcMHiVJ8khr/lczO5i0coIU6qoXg7FMnV3PBvipL6D2eENlrhmE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3208.namprd21.prod.outlook.com (2603:10b6:208:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.5; Wed, 23 Aug
 2023 01:00:55 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Wed, 23 Aug 2023
 01:00:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/hyperv: Add missing 'inline' to hv_snp_boot_ap() stub
Thread-Topic: [PATCH] x86/hyperv: Add missing 'inline' to hv_snp_boot_ap()
 stub
Thread-Index: AQHZ1SYcbxT92R5nv0CfAidrNqp7eK/3D+tA
Date:   Wed, 23 Aug 2023 01:00:55 +0000
Message-ID: <SA1PR21MB1335C1D74D05A582D90EA1A9BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230822-hv_snp_boot_ap-missing-inline-v1-1-e712dcb2da0f@kernel.org>
In-Reply-To: <20230822-hv_snp_boot_ap-missing-inline-v1-1-e712dcb2da0f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2730ef0d-6baf-48ab-a2f5-dc1032df3237;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-23T00:59:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3208:EE_
x-ms-office365-filtering-correlation-id: 1251281f-2496-4ef7-cd5b-08dba374679a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXb2en7tHhN04VQ/B/mYkKl5FJV0NgCCZA6X/TtoS+8Ml5Cr4QAr2xLNQcYxe9kBBGf4XQC00PY7Oh4DXNBr+YY6iJ7+V94t0FOOSiBcEQy3RPoFkLpex/KK1c7ejJ8MF0aoMx3sc6LUDURseZOulGvlWi7YIICgjREZchUBec+XmiIqRGCtI+NNwd5PiumTpirV4qXUHVOBZVD4rUgpq72sSkG/Rawb+f1w0z2qoL7yvUdDzIpFevGdVmU9y82WWPAUIERUSmYWKV3RfteN9g6eU5kHRvtZccvs2/5B9pxgHFESzE52ck0qrtnzw7tnrwpRm6EiX/5V9BfGJzGUPXbun/Kc4hswnN5NZSrBo3x0VuAfKU9zNfU9UKKrk57Z/8PduiSaxdnU7igWvgzVQAYbHGorQzFghWd36lp9KIudYKLJCkfTJTGPlApcbse/4P0rcB+WjXir5M9nkQUUSCE2+U2j6zfzJlpGRyAidQKNkwZaqBaLR0JFBiVrfaH60zeHzt5YQ5AhVJBrkusapLOx9S2k62cNqQY20uAyNixLpm7JZ3GgFYuX6s96xZBiBalBO2Hq+72C0OUuTSaHYfY5oabwuA4PI/Ow1hl+j9Z+DjULRphRfWTGlE7/R7k7tIJwIrCtTxFyoSXNp9WQVdDHSPMbmiEA1XDaLiMiIQ/sDRpyqgEN4clWecr11WOd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199024)(1800799009)(186009)(41300700001)(110136005)(9686003)(10290500003)(478600001)(55016003)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(6506007)(7696005)(76116006)(54906003)(316002)(4326008)(52536014)(8676002)(8936002)(5660300002)(33656002)(12101799020)(86362001)(4744005)(83380400001)(26005)(122000001)(38100700002)(38070700005)(82950400001)(82960400001)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0NKemdFTUp4RStPL2hMVlRHSHgwMkxKQnEvcnMyTlQycVN3T3p6T0JnWUZJ?=
 =?utf-8?B?Rk1UK05qcmxsbEhKdDk5TnhUd2tBQXFDZEdLcXg4SzZmSU9DZkcrY1FzTUNn?=
 =?utf-8?B?RGhacC90T1N4bDlSMDhtN0JoR1lEMTJNaU9PSVRTTEhHMXF5NHlkK1JJTmhx?=
 =?utf-8?B?NWJDUjU3MFlxSjRYTGc4eW82OXQyY2dnY2NPTitveWp6djI5elJIRzBqSExK?=
 =?utf-8?B?Wi8rSWZCSnhYbVUvQ1A2S0FKN2swMkp5N1pqVGRHdUlUaHhyOFdLeHhGQmxD?=
 =?utf-8?B?ZlU3NGpHNFZnTW42M2hCcm9HU3lkd0F3T1MwZjFTTHh2ckVNZ0preGRod1dO?=
 =?utf-8?B?Q0d3elVkeUtIUjlONkdSbjFsVE01MFZsTDZ2L1RpWmIwak1rWEl5eVpKTy9H?=
 =?utf-8?B?VkZmRDRJS3NFcytacCtHenhGT1VvMTlOTXF3UW4veWpnUnJLaW9SeUx0T2Js?=
 =?utf-8?B?OFVDWGZPZ0czM1RKaFkyMmx1YWQ0T1pWbENTQkR4SWRYcFppendibUZsQi9h?=
 =?utf-8?B?MGtQTnIvVStkZmhFQXhlS3YzZmEzNkxodjVaMjhUZWJEaWNaUHlRaVpHRWs0?=
 =?utf-8?B?QnpjSkIyd084eHNQaHlGbkdqRGs4VmJHMFZ4ZUljL1FSTVZ5ZG5TaUdid3g4?=
 =?utf-8?B?SWs2WjBsdmdBSTF0YlQvZTJ6VFA2azVhNGZTS1h6SUsyRzVEYW5USHhlTFJr?=
 =?utf-8?B?WkZDU244MklOYXBXc2J1Nm1IR0hJZmpWWWpPbjhIeFFIdGJDUDVmdUh3dFl0?=
 =?utf-8?B?Ty9aYlhCU0YvTkQrczhTL3FtSS9CQVBENzVaTktudzFFeHl2UWZTOUlGa0RL?=
 =?utf-8?B?dHgzN2x2ZU9qOER3L0pCQWRaeU9Xclh5R0FlOHRXVW4vcEJHanAxTGcvT2U4?=
 =?utf-8?B?ZlBBeG9HdGlFNFk3TjJmb1p1THhYdFJJVlpFZzBmeEl5UTNHQ0RSSW1WN1NK?=
 =?utf-8?B?b0Q1NDZVdjM2S1kvTytQdUpwOWYvL3FCeUVOb3RpTHRNR0JLaCtGZ0RMVWNj?=
 =?utf-8?B?OGsvcTRNVEJPb1k1VkFiUXR5LzhXemtOZHFmKzkyM2tVM0l6RzhwT1Q3Z3Zv?=
 =?utf-8?B?NjNBSlZsY25WYmt3N1ZXRDBSY1NoM0VSRlV5TWJGaWZzZ3lEc0FVekIxeEpH?=
 =?utf-8?B?TFIyeVlwRnhqVUQvUHNkaVZJd0FwTmM3T0ZhREVuc3J4ejFaRFBuVW9RcldW?=
 =?utf-8?B?YzA0TTI2YVhVY0M5NnRwRndHOUt2aFlrcWdGVkhlRzZMVlY2N0pNbDFvVmY3?=
 =?utf-8?B?Y2llNitlVzhIb080anpsQW8vQ3VTT1NPRWcrQ1pMZmIzT0hyS3N5NVpheXVY?=
 =?utf-8?B?SVg2d0RzWkhZRlZLeS9RdExjNXNVbDR4RDZBKzBZbk9XUFNHNFFTN3B2Z2M2?=
 =?utf-8?B?SGk5ek1OblM3M0dzOWRFY0VFS3YyMmVrTXlQTUxTZnJoRDlRU3RpeTZaVkF4?=
 =?utf-8?B?Tk1HR3U2b0RETStBT3BIeS9ScGIzWjV0NDM3YmpCeTZDdm5GYTQ2TFljeUkw?=
 =?utf-8?B?djBKS0dwTm5hM2tJcVNlR3psajV4QmErbGFjeEU5N3FhOWluZGlUV2F1MWV0?=
 =?utf-8?B?TDBRQ2o3Y1JoTFJLV0hUb252MXJnV05MdHUwYkFSTDFpc2E0dWx1S2E4UHRM?=
 =?utf-8?B?VkowU2syNDJSLzdlWUVXVFZ4RmU5SmZLVGdOc1VKd1VseUY4NzFLUVFhRy9r?=
 =?utf-8?B?OXdZVjVHODhURC9lQmp1Mm1mbHBmRnVad3FvTlQ4d0dLc1NabVJWV2NJU2pp?=
 =?utf-8?B?QkFXQ2xLRWNJMEcyY2lpZWcxZHBMc2NKT1pUYktONFFvZTMva3I0TDVkdHBl?=
 =?utf-8?B?bUZYdE02OC9MYTVPWEpqY0R0cUlDVlJHZGZFU2JFNzVnZ1VPRG1KdEhOSVV1?=
 =?utf-8?B?WktvZVJjcFNJTEFDNWkzSjlXa2k5NjJ0NkE4bHNxRzRDbFdsWHRqVkpSNzBS?=
 =?utf-8?B?Nkd4Zzc5V3FaOWM3NlRlem5adGgrNlIrNUJEd1NnMkJYZEV5QklCUXZ1Rk02?=
 =?utf-8?B?WGJTcUFXQU9zbS93Nk1hYzhnckJYSVlIcVZockovTk5OMHJud1RtRFFsZWtk?=
 =?utf-8?B?dllad1dtUTZYUm9nd0g0MHRaTCtuaG1nZmVBUkFWVkZsY2llZEZzRnNmWFRN?=
 =?utf-8?Q?rXuNaLXVsqAB132xjMJ74xgm8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1251281f-2496-4ef7-cd5b-08dba374679a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 01:00:55.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npN66ZfQ5J+1wID9zqTdYqy8tXJh7Ja2y3MfJ8VyVbm5pkVIyYBuiD5nsYR7L7iYYr/pSy1qGzbvu8XWnQNG/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1
ZXNkYXksIEF1Z3VzdCAyMiwgMjAyMyAxMToyNiBBTQ0KPiBbLi4uXQ0KPiBXaGVuIGJ1aWxkaW5n
IHdpdGhvdXQgQ09ORklHX0FNRF9NRU1fRU5DUllQVCwgdGhlcmUgYXJlIHNldmVyYWwNCj4gcmVw
ZWF0ZWQgaW5zdGFuY2VzIG9mIC1XdW51c2VkLWZ1bmN0aW9uIGR1ZSB0byBtaXNzaW5nICdpbmxp
bmUnIG9uDQo+IHRoZSBzdHViIG9mIGh5X3NucF9ib290X2FwKCk6DQo+IA0KPiAgIEluIGZpbGUg
aW5jbHVkZWQgZnJvbSBkcml2ZXJzL2h2L2h2X2NvbW1vbi5jOjI5Og0KPiAgIC4vYXJjaC94ODYv
aW5jbHVkZS9hc20vbXNoeXBlcnYuaDoyNzI6MTI6IGVycm9yOiAnaHZfc25wX2Jvb3RfYXAnDQo+
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1mdW5jdGlvbl0NCj4gICAgIDI3
MiB8IHN0YXRpYyBpbnQgaHZfc25wX2Jvb3RfYXAoaW50IGNwdSwgdW5zaWduZWQgbG9uZyBzdGFy
dF9pcCkgeyByZXR1cm4NCj4gMDsgfQ0KPiAgICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fg0KPiAgIGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IA0K
PiBBZGQgJ2lubGluZScgdG8gZml4IHRoZSB3YXJuaW5ncy4NCj4gDQo+IEZpeGVzOiA0NDY3NmJi
OWQ1NjYgKCJ4ODYvaHlwZXJ2OiBBZGQgc21wIHN1cHBvcnQgZm9yIFNFVi1TTlAgZ3Vlc3QiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQoN
ClJldmlld2VkLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0K

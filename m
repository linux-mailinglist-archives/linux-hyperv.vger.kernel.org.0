Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF776C077
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHAWfU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 18:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHAWfS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 18:35:18 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E551BE3;
        Tue,  1 Aug 2023 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1690929317;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NqzRNG8bI4/kBb+OMrG6n/fgnVRw0P5LyiLmWT5fJ/s=;
  b=Xe932+hFegLYFHuT2jDOCfTtoCKUACCAd/w0MttYoYqRXtmobfamxMDN
   1yaHWRzqrKqYnzkslRJJtTd7LSxCdtNcP0gDEKh1eqaXtz2bhVL5fu6UH
   vOFD5t11MUai7rmW5GhXp0osWV7YNYm0wxOG6pEXOe4crimzoLCEn/Fnc
   Q=;
X-IronPort-RemoteIP: 104.47.51.46
X-IronPort-MID: 118053144
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:CrCaUqNZeZ+eJrbvrR2EkMFynXyQoLVcMsEvi/4bfWQNrUoi0DEBz
 2oZCGmGPviIazSmeYtyO4znp0lSv8fSzdVqGwto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/vrRC9H5qyo42tI5gVmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0st6P0di1
 8IhEh4uMkiMrsC93rDgeMA506zPLOGzVG8ekldJ6GmDSNwAGNXESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PNxvza7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prraWzXumA9tOSNVU8NY1p0KW4lIyOSQyagGYmfbgqkjvANNQf
 hl8Fi0G6PJaGFaQZsXyWw2QpH+CowIGXNxRA6s25WmlzqvS/hbcBnkcQyRfQMIpudVwRjEw0
 FKN2dTzClRHqqCOUjSU8LuZtyi1PwAVNWJEbigBJSMJ4tzivJsyyAnOUN9lEaW1pt3tFHf7x
 DXihC0/hLhVkdQCyaSg1VDfjnSnoZ2hZhUp6xvaGH2s7gdRZJaoIYev7DDz7/laK52CZkKcp
 3VCkM+bhMgUBIDLlDGERuolFbSlof2CNVX0g1JiG4co7TmF4GO4cMZb5zQWDENoNNsUPD/2Z
 UjVkR1e6YUVP3awa6JzJYWrBKwCyanmCMTNTPfZZdkLf4M3cgKblAlqZEiNzyX2m1Mtub8wN
 I3dcsu2C3seT6N9w1KeQu4Hzb4tgDgz2W7JXp395xO92LGaaTieTrJtGFmHa+0iqriBqR/J2
 9xFMMKGwBJaFub5Z0H//Y8YLhYJIH49CJzng8ZNceePKQ1jXmomDpf5w74jcaRhnqJIhqHJ9
 HT7UUhdoHL2n3/OLy2Oa3Z+ePXuW4pyqTQwOilEFUqo3H0qesCr4aETfpA0bJEu8eAlxvlxJ
 9EVK5uoAflVTDnDvTMHYvHVqI1kaQTuhg+UOSehSCYwcoQmRAHT/NLgOAz1+0EmFieruNEsi
 7ym2BnSTZcKS0JlFsm+QPeuzF61uXUMsOdzVFHPOd5dZAPn940CAzD2lOE+J80XARHCwCaKk
 giRHBEUrPXMpIlz98PG7YiLtYqmEOtWGktcAnnV6quwOSDG/22lh4haX461kSv1UWr1/OCoY
 7xTxvSkavkfxg4W7cx7Dqphyr846533vbhGww94HXLNKVO2FrdnJXrA1s5K3kFQ+oJkVcKNc
 hrn0rFn1X+hYasJzHZ5yNIZU9m+
IronPort-HdrOrdr: A9a23:Kb02FKtJqrADtuplpc9ulfub7skDeNV00zEX/kB9WHVpm62j+/
 xG+c5x6faaslkssR0b9+xoWpPhfZqsz/9ICOAqVN/JMTUO01HYT72Kg7GSpgHIKmnT8fNcyL
 clU4UWMqyVMbGit7eZ3DWF
X-Talos-CUID: 9a23:AYh6zm1lYPMiy9OmNxLMdrxfN80bVFH/8k7qDWzkUWlAaraLSwSi0fYx
X-Talos-MUID: 9a23:OONluAvnolCGKmV+Vc2n2xZ9MeNWwpWXLH9Xsq0J4umCZHdxNGLI
X-IronPort-AV: E=Sophos;i="6.01,248,1684814400"; 
   d="scan'208";a="118053144"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2023 18:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUaHuJG5J/22sEHvsXH9tcZaRMNYe4gKfFCpzcEgt8qee2AovpQTOFOp8R+rrgAjOnqUbMfbWv/U4A1ijBWGIVpWoisEXK8XS3eDLXJN85r1WVZimI9Vwi1g3FQzQvqI+qGbIbDbGSTYrM0KJaVafjsWGLjpXfkTObBR2Fv4hfkfzB3QcOaiMtjmya4opqT5xzcAeMPKGhJ7kLnQeqHKyDq256cbFan8YCEFbAeJ9mERniJM+EH5OOX4yZloV6An37RgIY1d5qFmQF7lwmc6+d97JLXdY1JCcVcs2cHk7+uUpqQqYbw2+MbEncaKwJUgjosgDe3WYCRQuymddLUCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiYEYoytPD1M9SQHmaAJNFPgzUrmsNGjShgMwWmjyDE=;
 b=gKXKCaJWjHh3m8x3iqBVmio52guZqFq58X5rltovYZfTomA/8LAtfuNg48XCiMOo/EnKh6UgbuX002RvgKELXmXQ8N3wkvTJtkohsT2DCEljWkL7GZb8NgcjG5RvDb3Ctmr52apSt/f+VZrH9q0xcwfpRdy/PEC+d+wqI8jDAc7XjZYn+gu4LiFI3pxlU8x3L0m3bKoELJ9k/TXjYCvUBPb3GvduOOye1yo7I1dgrik1+BI0XYzS2b35oMk75oB9KR9hLZT2XDH7PtWrHqYmEz00Xgf/ovKQkL692drqgR21zwwlaEO5eFz8f2Uj6HQhIVy0uq5x7rxvesPK/F9reA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiYEYoytPD1M9SQHmaAJNFPgzUrmsNGjShgMwWmjyDE=;
 b=h35XZ/libgheuyvNuuhVIHqHpOF0N5bsKoZ7WYODhEBcWwkIC5qFX0BAcExTyp2R3xYIgka2dTkuv8rFcrtD/rc62AKb78cmPiMNDZ/sEJd8eTwgvoyUsMaYCj36xsJ5tYXZk/E1T8ZQ+k3S8wifl4crp7+21g9TVIb+FnHVQyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BN8PR03MB4916.namprd03.prod.outlook.com (2603:10b6:408:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 22:35:10 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::9410:217b:251f:2a98%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 22:35:10 +0000
Message-ID: <fb5cb37f-550e-1627-ff5e-bfd2e5696a26@citrix.com>
Date:   Tue, 1 Aug 2023 23:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-hyperv@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87fs53n6xd.ffs@tglx>
 <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <873513n31m.ffs@tglx> <87r0omjt8c.ffs@tglx>
In-Reply-To: <87r0omjt8c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BN8PR03MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ea66b-8cbb-46e3-950e-08db92df9019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xw4O1tz/ejz8dktygw/GI1FhSsnKM8f0Uk7Rseu4mcPpgf7fvRbU2pydzj71CT3anK5eZDkHPyEmJ0l6ZCCQ5t72foqEKOlmyy/Dmd25A7HYtF2kPbDLIOvJZm95rst1DXEqCy0PM0DyWNxrbUIypiOc2BvOlxD0A+NZElACIhT0NqD6BCqhBOMa1lxP9yZGNt2UgFe/XYoCfAB9ona//neQmsNjrByTbZfCfoiSDd1bcZAeQKGJLKNwlz7r8ef8RgL+XSNwElzcHVYs7bHyrJgp8EUIQ2O7R5lzDL7wwEEjeotaLAPvKC9pLO16OxtH+qhuLrnz0LqLVpEE7sU4HaTVxtxPayNNW5RJfT4uomQF98LMKxew7P92jNw+EwXpDm+WspoJFa38pbZ2zI69JIeklM9n3nfRAhgBPCnUdrZvLfzeM6YR+lUlED7ESsEvGrxk0qpHWyM40QtELpNWikw3cfOIBUi3iqo2+iBri6WSROxogw+ddOu9xFrGCsG1JYx9xFm0Fh+e8xpsPXbPWyTUCDe3FR139J8rqlrTK5/CYXHCBCgO+Jn32AZUIDNl5jofBheHyr1OYU2WalxcyMj/9d7w0S2zFc+bRnbwZNQIZy1bPli0l8VrbrzWOzmyFm9QnzmR0x6HHCVA4ypvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(66946007)(2906002)(4326008)(66556008)(66476007)(6486002)(6666004)(86362001)(31696002)(6512007)(83380400001)(478600001)(36756003)(186003)(82960400001)(26005)(6506007)(38100700002)(2616005)(53546011)(110136005)(54906003)(316002)(41300700001)(4744005)(8936002)(8676002)(31686004)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFOZHdLamdhKzJNQllpTTRsbUxZNUJnVzByam5leVkvOVpCZ2FRVFEvZTN5?=
 =?utf-8?B?T1Rsd0J1OTNvVFJrckNyYVExU0ZhR2l0SGNmWndJWUxoVTVyMXY4MW5JNm93?=
 =?utf-8?B?MVl3S0FkK1pZOERmWUNDdzBLRFFzc1VlbGRKS2lENHBoZStBZC9VbG1KVHgw?=
 =?utf-8?B?SjF3MnJuc0tUcTJORksvU0pCK2FHZUFTUEFSRUJ3ZHVJWmpDclJHdXNJaHRP?=
 =?utf-8?B?aHh5S1NTNzhzTzJveVo1emIzSFZYUVNTdGVmOW45dE5NN2pxdTRiUTk4dEVN?=
 =?utf-8?B?SG5jQlNrV2h6eW4xQWpYSDR2SDFIMExLWG84YnQvTkdiMXo1QXltYmJiTThL?=
 =?utf-8?B?TUdhTWtKbnJRdlZvaE1aVjdRcFFsTWY3OWpCNUpZajh0Sm9WREhJSlF2Wkh2?=
 =?utf-8?B?WnQ3WkRvdGQyZzIwa2hGZDBUcEgvb3k5WE10Y0hkLzF3OTBRVTVEZDlWQldz?=
 =?utf-8?B?QzB5WTkzM1NzcjFoNzJvTU8rV3lDckNaazJobnUvbEFrblBiR0tydFFqSmN5?=
 =?utf-8?B?dGlaQ2hibW9QOHpSK1U2RVNRNk5CN0lkRVdKeExkaTBYRGhGYW5oVTFzZDFx?=
 =?utf-8?B?N1JhaUhrL1dDZWZ0eEhob0YzMTJsRHA3N05HSnVMNkpWQUcwVUoyUjNyRHUx?=
 =?utf-8?B?NkNhOEZYOHFzYWNuN0cxSUoyemJ1aDExbU5YTFlNLzFjeENlUThDVXdLQkhr?=
 =?utf-8?B?OGlkWGJuWFZmajdmdkhRN2tPSVZHNTZlYlI3VmhWTnE4YmZoT0F1Uk9CWG13?=
 =?utf-8?B?dlo3T3FYOGNMZ25WV2hsNTZqYVpDM3BlemdHbkxLa1ZkVVFOR3FoS3N2YStn?=
 =?utf-8?B?cjNTWWM0WUx3L0lJOUNoMzJzUGNHbWJHd3NWOW5BYStpT0ZkWXlyQkVnQkRy?=
 =?utf-8?B?SjlFaG5OSmMrbUNTSlN1Y2ZBc1BKbUUrdytpa3dDSzdlNkU1OGhlZjdjRWN4?=
 =?utf-8?B?WUQxR3FlWHBweEdsRy9IT1RyNnFwcEJxZ1JmaVFBRzRGREZzR0c1dnlENmhI?=
 =?utf-8?B?aFBwS29IS2Nqc2NjR2IydklFODRTSWI0R0hvSzFOMmZXcS9JVVpQQ3BxbW52?=
 =?utf-8?B?N2themdSVTFsTGt3MXMzMWJSVng5YTNWd1BxOHpwZVBia2RNSUdPOTloRm1j?=
 =?utf-8?B?Y25lT1lML2xLUGtTNERTVll5S2MxemlEblYyTEYzNHhuYW5BeVY1M1NTV1BU?=
 =?utf-8?B?M05KVk45ZEhObk1FZUIwSnFseXI2N1lPYUwvelpSTndMcXFwZUR4dGQxd1c3?=
 =?utf-8?B?ekdkanlrejdPa3l3azdQNzJvNGVha1NZL2FoZVhUSXZybkNESzhNM2RNTTBM?=
 =?utf-8?B?bTB4Yk54Q3JxZjR4RjgyeEwwSXI3dVZJbUdIbFZJaVo4aFg3blVzZTRlbHBO?=
 =?utf-8?B?bW43am1ISnFMbWJVQnQwakk1cFlkbGNQQlVYd3Z0Qjd2V2ZlWHVhNHl0ZXg4?=
 =?utf-8?B?QzV1bUJWdmNlcU85NDBDK3RodHNObDhobGlqcGZ2amRuZWgvSzN6ZllyL0JE?=
 =?utf-8?B?QTRqTVlPMnBZdEZ3aXpubDRrY1MxWEZZZWNheWZ3ZVVuQ25vZ0RhWFlCKzQ4?=
 =?utf-8?B?VUhUbHQ4eTF1K1VXcVhwY3RUVDdZZlhwb1hoZVpRMnVWTHZvQTkweU1RUmI3?=
 =?utf-8?B?VkZHMEdUKzBBZmRwMVFqTXdhWG53bjVaOTE4ZWJ6S2x4a0pCNnVwMFA2M01H?=
 =?utf-8?B?YVVpN245NXQ4Z2Q0NzBGZFNtNmZTSGM5QTJKcHVWOUMyb0RZRVVrQUFoRVR0?=
 =?utf-8?B?dis5Q3huNC9SdXp2VjFtZDBqSHpEZG9qS3hxbU1YcW5pcm9GT2RnUncxdnlZ?=
 =?utf-8?B?WkNOODNmaU4vRnZxWnFwM2ZuMzBnc1pySTVYREVuaEI5NWJVYTRCY2plekFU?=
 =?utf-8?B?Z2VWODlrREw0MGIwMEZ0bTkyTEpsSUJIank2NjJWejFsS3pGanlxZW5jZlpO?=
 =?utf-8?B?Z2p2MS9yVHlaQjVIYmVYa1JvZmlzTW1WMmt0NllZcUdUcW1yZWtDaUs3UmV6?=
 =?utf-8?B?djRoV3lGSWoxa3EvZ1JiS2pRbnZlMkxPVGRVT1gvdUpqcTVkNzZRVHlWTi9V?=
 =?utf-8?B?MEhGZGRld3BHTGtlUEN2b3pncVA1eDZqbXE4YXYzMUl6L2hod3BqYXBPOHlQ?=
 =?utf-8?B?TFJEMk9YUU44NFdITkc4ZkkzWGQ0bk9jcGhPMFVITTA5Q09zK1QzdlY5Vm5H?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?byttQmtUUmtIalREVkxYR0lVQVhsV0owMVdaNDBZNXdNaTFFRmVlWC9JOS9G?=
 =?utf-8?B?aGhPQmN3NmZRbXNQMTNtTWk4NnR6b2xQQmxSWGxRd1N5azh1ZUM5SGZHS2U2?=
 =?utf-8?B?VW9kd1FHd2N6MlBpK0JDeHR0dC9hbUJuTWhEb3I0b0dRemJneERTZ0NzZHhP?=
 =?utf-8?B?SVAvbklZa1FmTFNxcHFjYmEyTk1BNFRndnNubTZmd1RvbUFaTEkwbUF5NU95?=
 =?utf-8?B?N3lVK1FMaWViaENXOG5KQVNXTnMrV0JURllNUVhKeEN5d2FNOEcxZG1qcmcw?=
 =?utf-8?B?V2F3SExlNWJ2dXljZUdTdHhqSDJtS1U3YVlQb0ZTZmJiaUp2SDVOZGU0amhM?=
 =?utf-8?B?VGRYQW8zUElzeklNaEVDei9XeEEyMktWbG9wTVdhakJWN0Q5OTZWSHRHUlVj?=
 =?utf-8?B?Q0d1SHhUSytDOEw3bXZPSm9QQmFINkRuVXdrc29vdUpTK0I3QjliWWJWSTJl?=
 =?utf-8?B?VW5SbXNBeU84ZklDUVJYLzhjOVgrdFE5RXptMDV4SDZ5dDJiNW55M1J4em1F?=
 =?utf-8?B?T09aQkM1c0RNV0QyTEZYSWx6U0pjNW9jNkRCQVh1R2pkNVdNVzltV1JwN1NY?=
 =?utf-8?B?cHE5WnF1am1LOXkyS3NKeUlHTzdJMG1OMGdFTk8xR3Zac0VMOFdRSURNYjF6?=
 =?utf-8?B?cmpiVjhZZk41WnhEZzZNOEhITllSanE0dEVlNjRxVjZNeTRDRE5rK3Z5VWVV?=
 =?utf-8?B?L0J0Z0pqRmJnQjRPNlgxOE5GSHBHb241V2VEL2YzL2h0SE12QTVCOWI2Q21p?=
 =?utf-8?B?MmNXc3Mrc082aE4wdWp0cElwUjE2K0FmRExFNWRhZjU5cUpUMXRpMk9UZ2pJ?=
 =?utf-8?B?dTZzVndoZ3U2dnB3VW9NNDVYRzBiNWQrazE5bytOY29YR0dDK3dQbFlURVdm?=
 =?utf-8?B?dkJtTE4zSlJVQ09rN3g2M3NUN3AzTkVtNTBhcE9obHpnZElpMXFYZmY4akZR?=
 =?utf-8?B?dHBCK2l1M2puSVdVS2lYUHkxWFhQUDdHR0hibksreHk0U0FKbEpRME5ybU15?=
 =?utf-8?B?aStWaVI4cXBzVFFBN2lBK2RpNDFjRFcxeC8zQ1FDMloxMGkvSnZMN1p3M25m?=
 =?utf-8?B?UDQzOEZNOGQ3Z0hHOWRTMXFwN0xUZysxTjkzU1liUUo3MG4xdFBXS1IzOWFL?=
 =?utf-8?B?MmhqeEJUNEd5NDc2MmhzZDVRTEQ0KzhQVDNpTU9aaEZkTlB1M1p0RnVXVHJx?=
 =?utf-8?B?WkdDSVNTeW9objRzSnRvVStBS2p2c2Uwc0FxcFZDSWg1VFZGanNGTjE2Zjd0?=
 =?utf-8?B?U3d3c1FYc3QvZjNEanRyRGVmc3hyODNVVTNSYWRLcGxPL1ViS1lLM1VWdHdu?=
 =?utf-8?B?WGFYdjdwUGxzQ0wwT1VmY2xjdUMwVnZpVzVJU2tabVoyUUJsSXJoZXJ5TExW?=
 =?utf-8?B?WEJxRThBdWpLSVpjMm5PY1c3blRHVTZEZVFybWEzU0djaHp0emVXV1Z0a00v?=
 =?utf-8?B?Ymk4U3N5YW1WNGVqYzZqWEdVdzA3d3hKNUxjWnM1Ky9GV1BBMHFJUktYT2M2?=
 =?utf-8?B?KzZzUVhkOUpXL1o0RjVMeE5sMFpoRjVLeUp3eGhkYkhXSFhKS3F4T2ZxNTV5?=
 =?utf-8?B?YVlaUTdYNFNFZ2ljd0RGZFFwZ2JhcEx2TEl2U3dRV2R1RjkvU1lFajZMOHNa?=
 =?utf-8?B?Q1IrV09aWExoYlEyNGpzZUl2c1hhYUQ2eGxNM2Nza3ZTOXVueWZCYTRoamIz?=
 =?utf-8?Q?d+JX6nlSMlUIEz7+K+cD?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ea66b-8cbb-46e3-950e-08db92df9019
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 22:35:09.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj5ZDso3s/vtt+ki9d41422d44h+rneviJ2FAUIp0PF+yc4pJZmATQTjPctZDBqw8aK4smggygpEkP3cg4JrUIYA+CC+9WOM//MhdQ7BWd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4916
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 01/08/2023 11:25 pm, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1688,7 +1688,7 @@ static void validate_apic_and_package_id
>  
>  	apicid = apic->cpu_present_to_apicid(cpu);
>  
> -	if (apicid != c->topo.apicid) {
> +	if (WARN_ON_ONCE(apicid != c->topo.apicid)) {
>  		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",

While you're fixing this, care to remove the chaotic-evil path of mixing
%u and %x with no 0x prefix?

~Andrew

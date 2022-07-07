Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1A56A34D
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiGGNQf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiGGNQe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 09:16:34 -0400
X-Greylist: delayed 13102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 06:16:32 PDT
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744332CDE4;
        Thu,  7 Jul 2022 06:16:31 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26793X85010169;
        Thu, 7 Jul 2022 09:37:42 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3h5a2tb6df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 09:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzwdYqa/ciDu9uUT6A/hOLSW2KUiYx+8AyqwWyl7GuqAqUoq90AORDVHV30kOwFHv2Q2UBdrw+z/1u1wfeB2lZewVcRYVzibmrzCN2T4cj2lbv/Uw/vIPkKL5efGTNVbjkg855abbFpypXfqPCl61eU7PJBtKIUJscj60QaaQCJ1GGGrxLshlLYb79e6K9NkFRH9ZWVQbV9XoTnli0yH1N+8ZP0UTbAyY+slD+U8wSvlnD4HtqStJUzYHvzm83baEWJgTqhyHGsGxsIyulxlx8NcKsmHoV22H95cXtU2lf/O0IniqpZrJNk4Fv1/VIfXGDS3PtOKC6/n9uV97ol05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruarQZmNj43SLW9TQWws2/Vu+4+WGtOYXsQcS/yMp6E=;
 b=Ziwr9X+k1nNJK2MT+8tESLGPWl4okA4jmQ5Ew23viNW3jUsHTVmA5N2f35WxlhDUeAiFZi9Kr+5C0UBgQERWH7iBVT6eVjN8ZTI0rplnma8wZHVeNbRgQUyMRJ4x7/d2H7SYlKUtRLgRWGTrtSPcju1Cir7yL07py73FNPl/BYRfmZtwPYqB0F4UyXWnbSXeADVThBYs0KTl4Kd/W/wtL1iHNz5WUvlOj+s1H+jANeq3dhRJ0rG5P6NRwcD9kSx5wc86f7S9FsruImI1G+xXk4Jx7f+u3ZwveFJQxp2Puf2Nny6+9OQlAnEFvX2wCim4+wEiJZM9ghIRl5TjUXgcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruarQZmNj43SLW9TQWws2/Vu+4+WGtOYXsQcS/yMp6E=;
 b=Wev+E8hZQ4m8qoqDrosX+H5/hR7Bpmpms+Uc80EHMcO5HWQlEmZK8rH6mIMdjCO3afJkzZnoMBdTiU/1LPmn3RZIMQPLaT2jb5gqg5zNR20y+Jk2KVvrDNH09hBsN91m5G53IPznF1oRL4v3fXV0l4SGlvwenes/ZHQfqKSrkNy1k1iwLooxRJAdnHslH2Y0YtrmCnLT1jUZNvZnZ4io1R2RVariPJXqPD+0sCEzEFBWRVbYKCfAsAKWaUQ87FfigIqxp4tSZ718BpEQTBZvW4dUImPGg49Fdki8eShNL1n3i/rS97j+OxRqfTNnUNpRmfgAorNdMH+MmGB8Gy+hTA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM0PR03MB4737.eurprd03.prod.outlook.com (2603:10a6:208:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 09:37:37 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::d87f:d45e:b2c6:c21]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::d87f:d45e:b2c6:c21%6]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 09:37:37 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Marc Zyngier <maz@kernel.org>, Oleksandr <olekstysh@gmail.com>
CC:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 6/8] genirq: Add and use an irq_data_update_affinity
 helper
Thread-Topic: [PATCH v3 6/8] genirq: Add and use an irq_data_update_affinity
 helper
Thread-Index: AQHYjYVqhNJG+4sRYkWyXsKH5qhjxa1sxkCAgAXY/ACAABASgA==
Date:   Thu, 7 Jul 2022 09:37:37 +0000
Message-ID: <4adea4b3-8e42-ef94-b29f-f375d167d55e@epam.com>
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-7-samuel@sholland.org>
 <c7171195-796a-e61e-f270-864985adc5c3@gmail.com>
 <87bku1mi3l.wl-maz@kernel.org>
In-Reply-To: <87bku1mi3l.wl-maz@kernel.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08768308-e26f-4792-3532-08da5ffc5455
x-ms-traffictypediagnostic: AM0PR03MB4737:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NVapwnjiW95BqQ7BoYPG6olQ4Bxy2HMcBhMalP14KVYpJijm5gEMc6/d4hoJnxQvpZxJHDPGZj60oqFrquf7yeMJXKNwTIZJgBoufSFIoOApzcI3qMtG8KufLQufGdoch9dzQaXxED/ga7v3S9ueOevm91WSIi0loqt7hyrbUr+JPYu8+2NU1YNIhghz7n6Ge+GiyvExtIVTAayJ2dqoqSpcRcp1rvr+FBYyeG1GZFTFyLFD3dvopMlxonNzCMkaWVVIuuJ1H6qcCzb5pyuwKb1lbMpIz6aXRgYljy6KY2uPKIIZTdKjLJIPsKe7c6xpCxprDYSMIXdqxX9AEJ6svymuXrzE5ZEG3/vtC6jup3DCivLU1AfL4LettBCyAba+bQDPmOucvs25JFxQ5h383d1Xx5C4sNouPCd5cELNiHNLLUofJ5ncoErc4Dw/nH7GFT/WaUKKHt1+VW6tsV+4nF4CPy3Uits/egQEeEPSlxCGk3cEUp7go1ZLXAEO2KTKmIrmXMDeyXP2P59aqHkUGBFvL735WtRF5ugeO+eTVRIYl1moewLTTkWYHbcQtXpxmI3J55sL32MvARVkt+zlKrCpNYQ2ogoQhZW5jEXgbhv4cW11iJ7yDUibT+YaLbOE1PKs7tdJCiQkWc3HRre9xSfpn44mkSpNfXPnNddBtzgaPqIHJSelJsRkcYCKzuqNNGJ4NzLIfFl8DNzZ5LbwjwtsDdbUr6Hh3xvV/JzrJEndHnM41E8nVBmKyVh4ccV3xzYwmhnLhw6ROWhuagHr5Iuj+1Zfc2IyCawwUbVRpeBuhJIEFthwwCEhzkgrr9gqZbqf3bJGc4qUnjim2sRD4mgUGrHfT96bqdO59kafxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(53546011)(4326008)(6506007)(55236004)(316002)(8676002)(91956017)(2906002)(64756008)(8936002)(86362001)(66556008)(66446008)(26005)(83380400001)(478600001)(6512007)(66946007)(76116006)(31686004)(7366002)(31696002)(38100700002)(38070700005)(66476007)(7406005)(5660300002)(7416002)(186003)(71200400001)(41300700001)(6486002)(36756003)(122000001)(2616005)(54906003)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elYrZ05YWWQvd0J5T2s1dHRiU3JqY05ZUUljd0J6eCtSMDVqTGV3Y3dEWXQv?=
 =?utf-8?B?MXk4TXFnZnpjeFNtNWUybmdtOGhhTnRqOGZhQ29VNGdkcjBzNmZGcjdnSVJo?=
 =?utf-8?B?TVFJM1RWdlQ1MmlYZGQ1a21Za1ZUT2JQQ3dOWWJNNVBSL0hxdUZpT0hRRHAx?=
 =?utf-8?B?OXZFNlVXU2xqK1VrVktKN1ljK1RjQ1RSNVg1Ty8zRXhtS3VVaEpYVUM4c3Rh?=
 =?utf-8?B?SFpYVldjME1DZDNZMEw5NExwMVVEeFdiZHVubnRrZVdCQzJPTXlOcDhKQ2p5?=
 =?utf-8?B?T1UxM1Q1UVpQZ0JzRngwVEpjTklKOU1TbTF1ZDZFQVBTTzNJTWJhVmJuSXd1?=
 =?utf-8?B?ZU5YdUtBNmJEa0xDYWdkUDM5SnFIempCTnlNRXBTWDEwMytKK3JSeVVxbUJH?=
 =?utf-8?B?MzhtL2tzL0lIMWRtZWNUN0puYWxuVHptdmlUMDlGWFZrWkkrMUhvVGt0RjRH?=
 =?utf-8?B?MTF0ZVBDRmN6dTFsS2dCL1RpNFRYbDZzdmgyTDdZQmVCVkZMSmdocDVYMjJJ?=
 =?utf-8?B?ZXAwVGoyc3JNd2dWMEFFVVEwYUNYeVRwTkc0bE15RmE2dEU3cFQvK1dxeVJ3?=
 =?utf-8?B?NW9lRlFzVnFzalMrOHFSY1VBTnFkbFY3VkZXajNVWmhVNWNya28wbXVUQ3pz?=
 =?utf-8?B?YldPM2M4NStKUUVIUFdtU09Od0IzQWc3QnNIZkFabUNpNE5nb3UwTU0rQVJ3?=
 =?utf-8?B?OFpWeHMweGpWeFRYM1lxaTF3K2RFNCsvZ2gxd1lSNW9jeXBNRFJ5V2RoRFRw?=
 =?utf-8?B?ekY4aTBVWnFCYjNocVNmRlBOT3lJdWJnTEcxMWc0Y0lMbjZXbGg5S0kzT1Vp?=
 =?utf-8?B?UVRSR0tZNFBLc3pqWEZaSk1qMDlUNnZZQUk2T1NoMUQzMXVYbzNIczFMSmpn?=
 =?utf-8?B?WmxvRWhWQVZtVWNTVTBKQzNkczY3VDVYdFNzTU9ZWEVSczhTK0ExQTd3RldX?=
 =?utf-8?B?eWJCRlV1U3Q5NXUxNWR6NHhzYzRGcXRtdUFybjk4TWlITWlmKzVNUndwT0wz?=
 =?utf-8?B?dkc4QWlUUUQzOWJKUVM3UXRsSzNUMnZhdmEwMlM3YWpqMjc2dzJBOWwwZXFX?=
 =?utf-8?B?M3FTUGU2SzVnZ3ZrQklZWXhnYnVmaGZXV1g1aG5SRVNldVBiYXowcjBjV1Jm?=
 =?utf-8?B?SnRtNEtZYUl2S2cxMm4yQWZ3VGFvZTc4NzgweXNtTHFYV3hNaEVLb0NtdXZm?=
 =?utf-8?B?MVFmY3NDczJ1d1p2UEt6VW5VTHM2K0daNFRlSitmbm1MaVdZQ1p1c2pGcTRX?=
 =?utf-8?B?L25iRkN0eHdyamYyYWdsMHN0Z1ZlRVBVTlZ5NEwrMTBEdVRtbTRpdFd3bG4w?=
 =?utf-8?B?SWM4U3liM0c4amRFSzgrTk5NeVhXNUNqcTZiZFphTlNNYzlUaUNNVnhxQVM0?=
 =?utf-8?B?cWoyUzFaeTN3dmRwbXdOMkdqSDBBRTNlZjdxWDR5aGUwcGZhUEUxYW50VW5h?=
 =?utf-8?B?RE9qYTdFaTJOU1FaZUovNFQ5SXBOTklYSWdoU1RPTHlxMUswYlhGeUc0Z09C?=
 =?utf-8?B?Y05WaDUwQVJTRjhMRTlkSXc5Z0VOTGRPTnQ2aG1xSnJDV0VYV0N5L2lDUEVM?=
 =?utf-8?B?d3c1b0NMaDJSRHQ3NjFzV0U2eGdScEtNeFlRUXc1VngvV09jY2pDOS94akZV?=
 =?utf-8?B?YTdyd0NZZ2xYd1dYZUlBdXNUTEhWcW1vdGlTdEl2Um5xOXkybHRIWkg3a3BL?=
 =?utf-8?B?VGhjNkJjVDBONHBSTk55cVlKT1Q1UWgrNVM2M2Evd3dQZWVndURFaEwwRDdG?=
 =?utf-8?B?aWRjNUVmYTRhTklCVU1vUmdtNVB0dURZZU1WN2g1NVhta2V0djV5VW95MEJB?=
 =?utf-8?B?S3RxQVpMNWMyMVFzTE9QNzVuSWtoNVpXV0t5YThmbzN2MnVXYkpZNk5tMDhy?=
 =?utf-8?B?ZndSMFlhZ096M253bUZkSFMyY0FkdzZVeTdWdDI0UHVsS2NRK2k5bENkbmhu?=
 =?utf-8?B?Vi9zOVdXVUZoMzVVckhFa2NQck1iK2g4RXlkSW1ndGJna25nTEVhSjY0Qk9E?=
 =?utf-8?B?SDJPcWEwU1ZteGJOcm82Q0JWR0VTeWU0R28zVGhWczJhcGdYYkhpOUFVcmZP?=
 =?utf-8?B?ZkszUmJ0WkxyL2hodFcyQlNTazMzZjNtcHc2RStidlVZODZyY1V0QXdjTnNU?=
 =?utf-8?B?UlUyUUtab3UydnJNV2d6OTZsWGJBSm4vZGtIZ0lCREMzdHA0TlhoTWlodkN4?=
 =?utf-8?Q?lsTpCOUfieyZwoafjdWvTG4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A2A6F3382BD034AA584D1B6BDD9A136@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08768308-e26f-4792-3532-08da5ffc5455
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 09:37:37.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryFqHslH8IpUz7b72RFfJvy4p1fW4q/x1ifnCR0X/7sOMjcumuUQn0fbg0IylHbthA6LFj9RR9LO/kflZiTFCn5LTqKCdQ5CGNoydWaZoLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4737
X-Proofpoint-GUID: lIES_1e9YhpkrSQcZ5YNMjaxWVftG38H
X-Proofpoint-ORIG-GUID: lIES_1e9YhpkrSQcZ5YNMjaxWVftG38H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQpPbiAwNy4wNy4yMiAxMTozOSwgTWFyYyBaeW5naWVyIHdyb3RlOg0KDQoNCkhlbGxvIE1hcmMN
Cg0KPiBPbiBTdW4sIDAzIEp1bCAyMDIyIDE2OjIyOjAzICswMTAwLA0KPiBPbGVrc2FuZHIgPG9s
ZWtzdHlzaEBnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDAxLjA3LjIyIDIzOjAwLCBTYW11
ZWwgSG9sbGFuZCB3cm90ZToNCj4+DQo+Pg0KPj4gSGVsbG8gU2FtdWVsDQo+Pg0KPj4+IFNvbWUg
YXJjaGl0ZWN0dXJlcyBhbmQgaXJxY2hpcCBkcml2ZXJzIG1vZGlmeSB0aGUgY3B1bWFzayByZXR1
cm5lZCBieQ0KPj4+IGlycV9kYXRhX2dldF9hZmZpbml0eV9tYXNrLCB1c3VhbGx5IGJ5IGNvcHlp
bmcgaW4gdG8gaXQuIFRoaXMgaXMNCj4+PiBwcm9ibGVtYXRpYyBmb3IgdW5pcHJvY2Vzc29yIGNv
bmZpZ3VyYXRpb25zLCB3aGVyZSB0aGUgYWZmaW5pdHkgbWFzaw0KPj4+IHNob3VsZCBiZSBjb25z
dGFudCwgYXMgaXQgaXMga25vd24gYXQgY29tcGlsZSB0aW1lLg0KPj4+DQo+Pj4gQWRkIGFuZCB1
c2UgYSBzZXR0ZXIgZm9yIHRoZSBhZmZpbml0eSBtYXNrLCBmb2xsb3dpbmcgdGhlIHBhdHRlcm4g
b2YNCj4+PiBpcnFfZGF0YV91cGRhdGVfZWZmZWN0aXZlX2FmZmluaXR5LiBUaGlzIGFsbG93cyB0
aGUgZ2V0dGVyIGZ1bmN0aW9uIHRvDQo+Pj4gcmV0dXJuIGEgY29uc3QgY3B1bWFzayBwb2ludGVy
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFu
ZC5vcmc+DQo+Pj4gLS0tDQo+Pj4NCj4+PiBDaGFuZ2VzIGluIHYzOg0KPj4+ICAgIC0gTmV3IHBh
dGNoIHRvIGludHJvZHVjZSBpcnFfZGF0YV91cGRhdGVfYWZmaW5pdHkNCj4+Pg0KPj4+ICAgIGFy
Y2gvYWxwaGEva2VybmVsL2lycS5jICAgICAgICAgIHwgMiArLQ0KPj4+ICAgIGFyY2gvaWE2NC9r
ZXJuZWwvaW9zYXBpYy5jICAgICAgIHwgMiArLQ0KPj4+ICAgIGFyY2gvaWE2NC9rZXJuZWwvaXJx
LmMgICAgICAgICAgIHwgNCArKy0tDQo+Pj4gICAgYXJjaC9pYTY0L2tlcm5lbC9tc2lfaWE2NC5j
ICAgICAgfCA0ICsrLS0NCj4+PiAgICBhcmNoL3BhcmlzYy9rZXJuZWwvaXJxLmMgICAgICAgICB8
IDIgKy0NCj4+PiAgICBkcml2ZXJzL2lycWNoaXAvaXJxLWJjbTYzNDUtbDEuYyB8IDQgKystLQ0K
Pj4+ICAgIGRyaXZlcnMvcGFyaXNjL2lvc2FwaWMuYyAgICAgICAgIHwgMiArLQ0KPj4+ICAgIGRy
aXZlcnMvc2gvaW50Yy9jaGlwLmMgICAgICAgICAgIHwgMiArLQ0KPj4+ICAgIGRyaXZlcnMveGVu
L2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgNyArKysrLS0tDQo+Pj4gICAgaW5jbHVkZS9saW51eC9p
cnEuaCAgICAgICAgICAgICAgfCA2ICsrKysrKw0KPj4+ICAgIDEwIGZpbGVzIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYWxwaGEva2VybmVsL2lycS5jIGIvYXJjaC9hbHBoYS9rZXJuZWwvaXJxLmMNCj4+PiBpbmRl
eCBmNmQyOTQ2ZWRiZDIuLjE1ZjJlZmZkNmJhZiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FscGhh
L2tlcm5lbC9pcnEuYw0KPj4+ICsrKyBiL2FyY2gvYWxwaGEva2VybmVsL2lycS5jDQo+Pj4gQEAg
LTYwLDcgKzYwLDcgQEAgaW50IGlycV9zZWxlY3RfYWZmaW5pdHkodW5zaWduZWQgaW50IGlycSkN
Cj4+PiAgICAJCWNwdSA9IChjcHUgPCAoTlJfQ1BVUy0xKSA/IGNwdSArIDEgOiAwKTsNCj4+PiAg
ICAJbGFzdF9jcHUgPSBjcHU7DQo+Pj4gICAgLQljcHVtYXNrX2NvcHkoaXJxX2RhdGFfZ2V0X2Fm
ZmluaXR5X21hc2soZGF0YSksDQo+Pj4gY3B1bWFza19vZihjcHUpKTsNCj4+PiArCWlycV9kYXRh
X3VwZGF0ZV9hZmZpbml0eShkYXRhLCBjcHVtYXNrX29mKGNwdSkpOw0KPj4+ICAgIAljaGlwLT5p
cnFfc2V0X2FmZmluaXR5KGRhdGEsIGNwdW1hc2tfb2YoY3B1KSwgZmFsc2UpOw0KPj4+ICAgIAly
ZXR1cm4gMDsNCj4+PiAgICB9DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvaWE2NC9rZXJuZWwvaW9z
YXBpYy5jIGIvYXJjaC9pYTY0L2tlcm5lbC9pb3NhcGljLmMNCj4+PiBpbmRleCAzNWFkY2Y4OTAz
NWEuLjk5MzAwODUwYWJjMSAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2lhNjQva2VybmVsL2lvc2Fw
aWMuYw0KPj4+ICsrKyBiL2FyY2gvaWE2NC9rZXJuZWwvaW9zYXBpYy5jDQo+Pj4gQEAgLTgzNCw3
ICs4MzQsNyBAQCBpb3NhcGljX3VucmVnaXN0ZXJfaW50ciAodW5zaWduZWQgaW50IGdzaSkNCj4+
PiAgICAJaWYgKGlvc2FwaWNfaW50cl9pbmZvW2lycV0uY291bnQgPT0gMCkgew0KPj4+ICAgICNp
ZmRlZiBDT05GSUdfU01QDQo+Pj4gICAgCQkvKiBDbGVhciBhZmZpbml0eSAqLw0KPj4+IC0JCWNw
dW1hc2tfc2V0YWxsKGlycV9nZXRfYWZmaW5pdHlfbWFzayhpcnEpKTsNCj4+PiArCQlpcnFfZGF0
YV91cGRhdGVfYWZmaW5pdHkoaXJxX2dldF9pcnFfZGF0YShpcnEpLCBjcHVfYWxsX21hc2spOw0K
Pj4+ICAgICNlbmRpZg0KPj4+ICAgIAkJLyogQ2xlYXIgdGhlIGludGVycnVwdCBpbmZvcm1hdGlv
biAqLw0KPj4+ICAgIAkJaW9zYXBpY19pbnRyX2luZm9baXJxXS5kZXN0ID0gMDsNCj4+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9pYTY0L2tlcm5lbC9pcnEuYyBiL2FyY2gvaWE2NC9rZXJuZWwvaXJxLmMN
Cj4+PiBpbmRleCBlY2VmMTdjN2MzNWIuLjI3NWI5ZWE1OGM2NCAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL2lhNjQva2VybmVsL2lycS5jDQo+Pj4gKysrIGIvYXJjaC9pYTY0L2tlcm5lbC9pcnEuYw0K
Pj4+IEBAIC01Nyw4ICs1Nyw4IEBAIHN0YXRpYyBjaGFyIGlycV9yZWRpciBbTlJfSVJRU107IC8v
ID0geyBbMCAuLi4gTlJfSVJRUy0xXSA9IDEgfTsNCj4+PiAgICB2b2lkIHNldF9pcnFfYWZmaW5p
dHlfaW5mbyAodW5zaWduZWQgaW50IGlycSwgaW50IGh3aWQsIGludCByZWRpcikNCj4+PiAgICB7
DQo+Pj4gICAgCWlmIChpcnEgPCBOUl9JUlFTKSB7DQo+Pj4gLQkJY3B1bWFza19jb3B5KGlycV9n
ZXRfYWZmaW5pdHlfbWFzayhpcnEpLA0KPj4+IC0JCQkgICAgIGNwdW1hc2tfb2YoY3B1X2xvZ2lj
YWxfaWQoaHdpZCkpKTsNCj4+PiArCQlpcnFfZGF0YV91cGRhdGVfYWZmaW5pdHkoaXJxX2dldF9p
cnFfZGF0YShpcnEpLA0KPj4+ICsJCQkJCSBjcHVtYXNrX29mKGNwdV9sb2dpY2FsX2lkKGh3aWQp
KSk7DQo+Pj4gICAgCQlpcnFfcmVkaXJbaXJxXSA9IChjaGFyKSAocmVkaXIgJiAweGZmKTsNCj4+
PiAgICAJfQ0KPj4+ICAgIH0NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9pYTY0L2tlcm5lbC9tc2lf
aWE2NC5jIGIvYXJjaC9pYTY0L2tlcm5lbC9tc2lfaWE2NC5jDQo+Pj4gaW5kZXggZGY1YzI4ZjI1
MmUzLi4wMjVlNTEzM2M4NjAgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9pYTY0L2tlcm5lbC9tc2lf
aWE2NC5jDQo+Pj4gKysrIGIvYXJjaC9pYTY0L2tlcm5lbC9tc2lfaWE2NC5jDQo+Pj4gQEAgLTM3
LDcgKzM3LDcgQEAgc3RhdGljIGludCBpYTY0X3NldF9tc2lfaXJxX2FmZmluaXR5KHN0cnVjdCBp
cnFfZGF0YSAqaWRhdGEsDQo+Pj4gICAgCW1zZy5kYXRhID0gZGF0YTsNCj4+PiAgICAgIAlwY2lf
d3JpdGVfbXNpX21zZyhpcnEsICZtc2cpOw0KPj4+IC0JY3B1bWFza19jb3B5KGlycV9kYXRhX2dl
dF9hZmZpbml0eV9tYXNrKGlkYXRhKSwgY3B1bWFza19vZihjcHUpKTsNCj4+PiArCWlycV9kYXRh
X3VwZGF0ZV9hZmZpbml0eShpZGF0YSwgY3B1bWFza19vZihjcHUpKTsNCj4+PiAgICAgIAlyZXR1
cm4gMDsNCj4+PiAgICB9DQo+Pj4gQEAgLTEzMiw3ICsxMzIsNyBAQCBzdGF0aWMgaW50IGRtYXJf
bXNpX3NldF9hZmZpbml0eShzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEsDQo+Pj4gICAgCW1zZy5hZGRy
ZXNzX2xvIHw9IE1TSV9BRERSX0RFU1RfSURfQ1BVKGNwdV9waHlzaWNhbF9pZChjcHUpKTsNCj4+
PiAgICAgIAlkbWFyX21zaV93cml0ZShpcnEsICZtc2cpOw0KPj4+IC0JY3B1bWFza19jb3B5KGly
cV9kYXRhX2dldF9hZmZpbml0eV9tYXNrKGRhdGEpLCBtYXNrKTsNCj4+PiArCWlycV9kYXRhX3Vw
ZGF0ZV9hZmZpbml0eShkYXRhLCBtYXNrKTsNCj4+PiAgICAgIAlyZXR1cm4gMDsNCj4+PiAgICB9
DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcGFyaXNjL2tlcm5lbC9pcnEuYyBiL2FyY2gvcGFyaXNj
L2tlcm5lbC9pcnEuYw0KPj4+IGluZGV4IDBmZTJkNzlmYjEyMy4uNWViYjE3NzFiNGFiIDEwMDY0
NA0KPj4+IC0tLSBhL2FyY2gvcGFyaXNjL2tlcm5lbC9pcnEuYw0KPj4+ICsrKyBiL2FyY2gvcGFy
aXNjL2tlcm5lbC9pcnEuYw0KPj4+IEBAIC0zMTUsNyArMzE1LDcgQEAgdW5zaWduZWQgbG9uZyB0
eG5fYWZmaW5pdHlfYWRkcih1bnNpZ25lZCBpbnQgaXJxLCBpbnQgY3B1KQ0KPj4+ICAgIHsNCj4+
PiAgICAjaWZkZWYgQ09ORklHX1NNUA0KPj4+ICAgIAlzdHJ1Y3QgaXJxX2RhdGEgKmQgPSBpcnFf
Z2V0X2lycV9kYXRhKGlycSk7DQo+Pj4gLQljcHVtYXNrX2NvcHkoaXJxX2RhdGFfZ2V0X2FmZmlu
aXR5X21hc2soZCksIGNwdW1hc2tfb2YoY3B1KSk7DQo+Pj4gKwlpcnFfZGF0YV91cGRhdGVfYWZm
aW5pdHkoZCwgY3B1bWFza19vZihjcHUpKTsNCj4+PiAgICAjZW5kaWYNCj4+PiAgICAgIAlyZXR1
cm4gcGVyX2NwdShjcHVfZGF0YSwgY3B1KS50eG5fYWRkcjsNCj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pcnFjaGlwL2lycS1iY202MzQ1LWwxLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWJjbTYz
NDUtbDEuYw0KPj4+IGluZGV4IDE0MmE3NDMxNzQ1Zi4uNjg5OWUzNzgxMGE4IDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtYmNtNjM0NS1sMS5jDQo+Pj4gKysrIGIvZHJpdmVy
cy9pcnFjaGlwL2lycS1iY202MzQ1LWwxLmMNCj4+PiBAQCAtMjE2LDExICsyMTYsMTEgQEAgc3Rh
dGljIGludCBiY202MzQ1X2wxX3NldF9hZmZpbml0eShzdHJ1Y3QgaXJxX2RhdGEgKmQsDQo+Pj4g
ICAgCQllbmFibGVkID0gaW50Yy0+Y3B1c1tvbGRfY3B1XS0+ZW5hYmxlX2NhY2hlW3dvcmRdICYg
bWFzazsNCj4+PiAgICAJCWlmIChlbmFibGVkKQ0KPj4+ICAgIAkJCV9fYmNtNjM0NV9sMV9tYXNr
KGQpOw0KPj4+IC0JCWNwdW1hc2tfY29weShpcnFfZGF0YV9nZXRfYWZmaW5pdHlfbWFzayhkKSwg
ZGVzdCk7DQo+Pj4gKwkJaXJxX2RhdGFfdXBkYXRlX2FmZmluaXR5KGQsIGRlc3QpOw0KPj4+ICAg
IAkJaWYgKGVuYWJsZWQpDQo+Pj4gICAgCQkJX19iY202MzQ1X2wxX3VubWFzayhkKTsNCj4+PiAg
ICAJfSBlbHNlIHsNCj4+PiAtCQljcHVtYXNrX2NvcHkoaXJxX2RhdGFfZ2V0X2FmZmluaXR5X21h
c2soZCksIGRlc3QpOw0KPj4+ICsJCWlycV9kYXRhX3VwZGF0ZV9hZmZpbml0eShkLCBkZXN0KTsN
Cj4+PiAgICAJfQ0KPj4+ICAgIAlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaW50Yy0+bG9j
aywgZmxhZ3MpOw0KPj4+ICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3BhcmlzYy9pb3NhcGljLmMg
Yi9kcml2ZXJzL3BhcmlzYy9pb3NhcGljLmMNCj4+PiBpbmRleCA4YTNiMGMzYTFlOTIuLjNhOGM5
ODYxNTYzNCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3BhcmlzYy9pb3NhcGljLmMNCj4+PiAr
KysgYi9kcml2ZXJzL3BhcmlzYy9pb3NhcGljLmMNCj4+PiBAQCAtNjc3LDcgKzY3Nyw3IEBAIHN0
YXRpYyBpbnQgaW9zYXBpY19zZXRfYWZmaW5pdHlfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZCwNCj4+
PiAgICAJaWYgKGRlc3RfY3B1IDwgMCkNCj4+PiAgICAJCXJldHVybiAtMTsNCj4+PiAgICAtCWNw
dW1hc2tfY29weShpcnFfZGF0YV9nZXRfYWZmaW5pdHlfbWFzayhkKSwNCj4+PiBjcHVtYXNrX29m
KGRlc3RfY3B1KSk7DQo+Pj4gKwlpcnFfZGF0YV91cGRhdGVfYWZmaW5pdHkoZCwgY3B1bWFza19v
ZihkZXN0X2NwdSkpOw0KPj4+ICAgIAl2aS0+dHhuX2FkZHIgPSB0eG5fYWZmaW5pdHlfYWRkcihk
LT5pcnEsIGRlc3RfY3B1KTsNCj4+PiAgICAgIAlzcGluX2xvY2tfaXJxc2F2ZSgmaW9zYXBpY19s
b2NrLCBmbGFncyk7DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2gvaW50Yy9jaGlwLmMgYi9k
cml2ZXJzL3NoL2ludGMvY2hpcC5jDQo+Pj4gaW5kZXggMzU4ZGY3NTEwMTg2Li44MjhkODFlMDJi
MzcgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9zaC9pbnRjL2NoaXAuYw0KPj4+ICsrKyBiL2Ry
aXZlcnMvc2gvaW50Yy9jaGlwLmMNCj4+PiBAQCAtNzIsNyArNzIsNyBAQCBzdGF0aWMgaW50IGlu
dGNfc2V0X2FmZmluaXR5KHN0cnVjdCBpcnFfZGF0YSAqZGF0YSwNCj4+PiAgICAJaWYgKCFjcHVt
YXNrX2ludGVyc2VjdHMoY3B1bWFzaywgY3B1X29ubGluZV9tYXNrKSkNCj4+PiAgICAJCXJldHVy
biAtMTsNCj4+PiAgICAtCWNwdW1hc2tfY29weShpcnFfZGF0YV9nZXRfYWZmaW5pdHlfbWFzayhk
YXRhKSwgY3B1bWFzayk7DQo+Pj4gKwlpcnFfZGF0YV91cGRhdGVfYWZmaW5pdHkoZGF0YSwgY3B1
bWFzayk7DQo+Pj4gICAgICAJcmV0dXJuIElSUV9TRVRfTUFTS19PS19OT0NPUFk7DQo+Pj4gICAg
fQ0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2Ry
aXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+Pj4gaW5kZXggNDZkOTI5NWQ5YTZlLi41
ZTgzMjFmNDNjYmQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19i
YXNlLmMNCj4+PiArKysgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPj4+IEBA
IC01MjgsOSArNTI4LDEwIEBAIHN0YXRpYyB2b2lkIGJpbmRfZXZ0Y2huX3RvX2NwdShldnRjaG5f
cG9ydF90IGV2dGNobiwgdW5zaWduZWQgaW50IGNwdSwNCj4+PiAgICAJQlVHX09OKGlycSA9PSAt
MSk7DQo+Pj4gICAgICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1NNUCkgJiYgZm9yY2VfYWZmaW5p
dHkpIHsNCj4+PiAtCQljcHVtYXNrX2NvcHkoaXJxX2dldF9hZmZpbml0eV9tYXNrKGlycSksIGNw
dW1hc2tfb2YoY3B1KSk7DQo+Pj4gLQkJY3B1bWFza19jb3B5KGlycV9nZXRfZWZmZWN0aXZlX2Fm
ZmluaXR5X21hc2soaXJxKSwNCj4+PiAtCQkJICAgICBjcHVtYXNrX29mKGNwdSkpOw0KPj4+ICsJ
CXN0cnVjdCBpcnFfZGF0YSAqZGF0YSA9IGlycV9nZXRfaXJxX2RhdGEoaXJxKTsNCj4+PiArDQo+
Pj4gKwkJaXJxX2RhdGFfdXBkYXRlX2FmZmluaXR5KGRhdGEsIGNwdW1hc2tfb2YoY3B1KSk7DQo+
Pj4gKwkJaXJxX2RhdGFfdXBkYXRlX2VmZmVjdGl2ZV9hZmZpbml0eShkYXRhLCBjcHVtYXNrX29m
KGNwdSkpOw0KPj4+ICAgIAl9DQo+Pg0KPj4NCj4+IE5pdDogY29tbWl0IGRlc2NyaXB0aW9uIHNh
eXMgYWJvdXQgcmV1c2luZyBpcnFfZGF0YV91cGRhdGVfYWZmaW5pdHkoKQ0KPj4gb25seSwgYnV0
IGhlcmUgd2UgYWxzbyByZXVzZSBpcnFfZGF0YV91cGRhdGVfZWZmZWN0aXZlX2FmZmluaXR5KCks
IHNvDQo+PiBJIHdvdWxkIG1lbnRpb24gdGhhdCBpbiB0aGUgZGVzY3JpcHRpb24uDQo+Pg0KPj4g
UmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0Bl
cGFtLmNvbT4gIyBYZW4gYml0cw0KPiBiNCBzaG91dHMgYmVjYXVzZSBvZiB5b3VyIGVtYWlsIGFk
ZHJlc3M6DQo+DQo+IE5PVEU6IHNvbWUgdHJhaWxlcnMgaWdub3JlZCBkdWUgdG8gZnJvbS9lbWFp
bCBtaXNtYXRjaGVzOg0KPiAgICAgICEgVHJhaWxlcjogUmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBU
eXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4gIyBYZW4gYml0cw0KPiAg
ICAgICBNc2cgRnJvbTogT2xla3NhbmRyIDxvbGVrc3R5c2hAZ21haWwuY29tPg0KDQpzb3JyeSBm
b3IgdGhlIGluY29udmVuaWVuY2UNCg0KDQo+DQo+IEkndmUgdXNlZCB0aGUgdGFnIGFueXdheSwN
Cg0KDQp0aGFuayB5b3UNCg0KDQo+ICAgYnV0IHlvdSBtYXkgd2FudCB0byBmaXggeW91ciBzZXR1
cCBpbiB0aGUNCj4gZnV0dXJlLg0KDQp5ZXMsIHdpbGwgZG8NCg0KDQo+DQo+IFRoYW5rcywNCj4N
Cj4gCU0uDQo+DQotLSANClJlZ2FyZHMsDQoNCk9sZWtzYW5kciBUeXNoY2hlbmtvDQo=

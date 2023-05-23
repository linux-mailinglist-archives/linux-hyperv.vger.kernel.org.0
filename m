Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46BB70D2B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 06:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEWEFK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 00:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEWEFJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 00:05:09 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128C93;
        Mon, 22 May 2023 21:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXFZVsi3bEZapT5VkdWRCFarECRlR+nU+S/4Wuaw7kQUltOE1F0OhOIsSXq3SNQJNJyFsQgXmMhAdNrbdJn9QXnUBBrWaojLHJ2+M7hZkDA1s3CC56DjA/yPmvBTeCWIIGK5LuJqfF6tOwI4GbA4/GxQh3YwliO5ednUFFPTL1Dvbfymrcilf2Wz6dNfHpaRZ+RdMTjoYj2gbGe3WtRb8znBX6z8Z5xBZSc6sSnctDghNMMruEZC6BhMmzNPT7gzsfn+yqsne/Sh+oUMKkTKQ81aQwvtht3oIoLpqceK1gzD2HYeGNDGDXtEyX706RUZq//JHiO62BrFE2/wi1nyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nWaDmP18SdNxf4/fcY6zpFVFDG1idejqAT52A0489g=;
 b=gGQsX5zvfRsx/JSCItgYvD/U18rfmKIu2dMqwrdgjPYJa6G0YHU0DfKLs+gEb6tZtvgdVwxI3/1zuXpvOKPmJQxobb1Deh3H+r1s4PGnflEYTNznKOfc9mXT/hqHfJXTUEzMt4tuo5J4Jh66JuW2QYD8ihiQ0NiUcy+gRZd6Qm2ZsQDhhV4/3Gc/gMUjqOgX/aZfCo3QJ+BgZBhayW2S4kOk81Tz2grUvuW1O7Tg82oURsd0SG7isshY+FhqdLkz9um7dvfkYK/Qywc0iSeYen0U+E5HsQ9MYFvopoeW4Sw70hcqG6lzGeHPQGKmWun9kKNAuGOcMS2Wj2v0QAjgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nWaDmP18SdNxf4/fcY6zpFVFDG1idejqAT52A0489g=;
 b=jYV7bLCNUMTuNOKB6jn8lwW4ezy25NmBwrd5N4Rb+v4s8nOBaHicnMNIR3gi27fleaHptkNBC1p2UoM3Ivvcw46eEuuzyqdGeehzdBM4X8r4NSw9g23v1z1XZZRfXEAtiVMKs1gSfXVlF1PUxfQcDxLYmBX4///VsgdGxjd4Ius=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3511.namprd21.prod.outlook.com (2603:10b6:208:3d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12; Tue, 23 May
 2023 04:05:05 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.004; Tue, 23 May 2023
 04:05:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix
 CPU online sequencing
Thread-Topic: [PATCH 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to
 fix CPU online sequencing
Thread-Index: AQHZil8FdlPYyPfgQE61m+Ed5f3Ik69nQmfQ
Date:   Tue, 23 May 2023 04:05:05 +0000
Message-ID: <SA1PR21MB1335C537D5C7ADB284CF245FBF40A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
 <1684506832-41392-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1684506832-41392-2-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cc6cd078-e3ac-4619-96c7-b1a840dc0145;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T04:03:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3511:EE_
x-ms-office365-filtering-correlation-id: 2c9c036e-624d-4ae1-67a4-08db5b42e3ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVy6nn594mmnMGITanaKFsR2kk0XId+S0cD5twDtqU/S/qEopuPNzlVAGK3ApcuHxSyvXHlostA3FZb9FoosUJxMfRAN2DUt/h3mGtq0ZDn1ZzyytA9gYvbAesZ3oNm/PyvqXmx7kyh0eeEU0opHTsOlungYvvqwRHJzl1U7HQG4bx/YuZHZGns0Go/jF/AouI4/sa4HMp3c48orxyLXvkQQUnLiJgGHEd41o5UtItTTfpc4uupsRU9YqnV3kyUtxA9tr/fDyN53jMCO2cCpt5nO6rna6tN3jrWzzbtf4tQIwx7/zaxR2GlL8MZqx0sNBCVMzhB6+AjPiIN8537xKAklSs31bXh883gzzbfNjfzUV/jhg4iyvpQzmXnV0hbFXQZytMRd/gw2l4VubgORByepmORy3CwG/Ep++ufQKihVJBViurqnzYOa/EEhPcimjvgxDboBy2B2i/iNy6nQAwf5UHz5aQjHGdcPTjo/QAhWxJQc51CYC8QT535Pb+RbO/on8iplQaPFJvuenbHFeQ6173bIdm7GZjGp4sHwS4f8OJZOOiKN+cLuS8mr9/IQ5Mt/UpQeQOk2bCTYa4WuqUMZYojMHKwkpecZoH5fCSjxuPegYYlFjEUiegqZjUKPlYOr1KM0CLS6xRL/CBeR7YeKI0AOJE1TCDvXIjGR6oJ8J34qfs7ZDQ5iuEFLxZM9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(8990500004)(83380400001)(186003)(2906002)(4744005)(86362001)(33656002)(38070700005)(38100700002)(82960400001)(82950400001)(921005)(122000001)(55016003)(52536014)(5660300002)(8936002)(8676002)(7416002)(110136005)(10290500003)(66476007)(64756008)(66556008)(76116006)(66946007)(66446008)(7696005)(478600001)(41300700001)(786003)(71200400001)(316002)(9686003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tR7CfIGx0tiP5Zu73msn4v4K1W/YXcNs4AUKS1G8+MWKjdUTB0ZobL4CdvHh?=
 =?us-ascii?Q?TgO+WmIj02wNOeD9V+ZxOU8awakps0CEHguNfjzpPlfoz4ZKJY8KSpF+myV+?=
 =?us-ascii?Q?jTX+TpL6O5VXxFbUz4qGut5lgT7DcFjjggxH02JtyIhfqm1qpvgvYPoPhdvd?=
 =?us-ascii?Q?Rt/3gPxY4MimKJsxxtgTkXqAhCX1faewLOG9VeM5VC5EKogS6TN5WTFEtmwZ?=
 =?us-ascii?Q?Z8QCPsAvIGoHYVLKZ0UImQHflf93mDXz6i0LqVDShrUxp+7XEF1KZRfSJV1/?=
 =?us-ascii?Q?tZbWw1UkB65kr5kmdRpTIW1/KFxovNRZPzTlHCIKk0d+5NH/ty7M8XSq808T?=
 =?us-ascii?Q?5NST/lgjP97s98Rss/MADG1ygwnbbDB/hqCZsT4kyV9ykMj7amMOMKGdbvMK?=
 =?us-ascii?Q?vlK9ql2aIZoAg8FS6KsI0h2+PqdUNEHtCjHBYdIhshyICUAzNOkzKTaAUc9p?=
 =?us-ascii?Q?XKZlka5L01F17u7ULnzCGq85HTr0u/xek8N4b0ZpJTpDI7rsB5SvGi8E6EMG?=
 =?us-ascii?Q?OacZeVM2QF54QEGaMy6FhR8vfPzVvZ6SIaq85iMYzC3bA0XdFwQaIZFHmWp0?=
 =?us-ascii?Q?8J3Whqc/1XZT/PxKz4NOX+RMH1j0dli9Kp7wP8fqnhv7jIVPQZ/LqewbF38r?=
 =?us-ascii?Q?c9xiA6kCmY8pxPaVnB+GKh4Gglfcyp1B6NsgwqH7KyqIuVimb87bJOu1Amor?=
 =?us-ascii?Q?h+eKraNLGN0pKOgsrYG3A/9IK/SBckBbVqqGiuw8nLkQqioezB6Cc6RtAw++?=
 =?us-ascii?Q?C3OJKjzaSBJmnkJKHERRSLFm9TGiWDLy3Rqid60riXSMa+bPbwJAcrykWq7g?=
 =?us-ascii?Q?DCUkTJMAaL+y0Y9+4vehiSha0VAnotZF1itPBcxzODbPz8uK0skTXWj9+Fxw?=
 =?us-ascii?Q?rx46z+YVJzdOSsUDhI5fJSYDHVfO8oYpLEbXXDKjJJaL4HVNpAFb59rqV6PX?=
 =?us-ascii?Q?TXxnIczRP84bHz8Cq/4Bxwp8FtOVjWDzfa9ctLnGTFcUFSPXrF+gt3j6qzF8?=
 =?us-ascii?Q?a9avJmkDotjmyJNVMWcfF6c3nlLR97a0UiWCUaUzQzeS3iJGliVPcZCl6cuM?=
 =?us-ascii?Q?2BVMw+9Y5tXKC4O026MRAmk4KMDssVwkmbZ/2hXxotKa9Y/E9EN3/a1VE8Xw?=
 =?us-ascii?Q?iDjR7iY7AFeZxTLSZTiD10vmUxaoFI4kJS/W4aPS01jjIMQA8Wmiwj6BTq64?=
 =?us-ascii?Q?3RcmTajwNX2HNMmLVQtXw+Wpt5tPdTOSHAyzAnalw4EmpRDt8XsjsNWwITlR?=
 =?us-ascii?Q?ziMdggnmpLfJLC0kHxyz4rRfDLJht60el0lNMX0uikX71bUpSC3BQ3fvFxiY?=
 =?us-ascii?Q?kGs0QgmvmK09I2D1eDXtG2xAZ/udQfg0ArQ+sLguQiU1p31ilJLz0zVKn20z?=
 =?us-ascii?Q?SEYO5tio0TCZ8fI6gpJSnASBU6FwNKSHsmRIFOIKMCtWJ3v6uYjr1D++6r0p?=
 =?us-ascii?Q?ZMviRHFW9tqNTcR0bPRvO4Z16Mkw8vmEOocNzeFPfUDW+kPpfEzHL24AJViJ?=
 =?us-ascii?Q?4Pn+OzSSWjNWl1qwFUzYt4VfdU0csKC+1OT4vqsnSIB+YVMiNXIP0NNWsfRo?=
 =?us-ascii?Q?+Orl/zNQQGQkeecT/X7t5ctL+p6zNl0KV9HBteM5m3qhnG2BaXNf8qOzMuZG?=
 =?us-ascii?Q?LWnfaYfn9pfs6xYk5iDKUwBUmMfYcQ3ox/vHIQXNCxD3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9c036e-624d-4ae1-67a4-08db5b42e3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 04:05:05.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0dLZ9f+udWX+vXqflFzHSoAOI1ur7tS0helUlpmTfnQndzLw7jNLcITyOti33PqF/Qcm0pv1+x222Upu/S3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Friday, May 19, 2023 7:34 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> ...
> State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence
> the initialization of hyperv_pcpu_input_arg. Use this use new state

s/this use/ this

> for Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
> early enough.


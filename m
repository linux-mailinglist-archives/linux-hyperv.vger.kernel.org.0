Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD070E4B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjEWSbM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbjEWSbL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 14:31:11 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CE8F;
        Tue, 23 May 2023 11:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Ot7guEQHDnMFjyhEXyvDK9ShYNNyHKezRjnaRiR3cpDiGkfXl9grn8X2xn1ZmRtotz1d57D5z72yO26+/y98OBxOLcJNWVceoFfov6Oi75dAL3aroHXbkUc5ZJCBXvI0W6tJMfzUN5g61pf+QN1Ia331v5NG5Px1e4NqwsdFQsDjiVuHwvZunn/ICkkSpT+6nWINhROJVaJY+8dzkFYIlTmKPoQ/vUWQiFKaDeYHv6CL5G8uESoM1AvCYvSMSRmun5EM/OFe+9+nMQcWJBb488wh3pFzKu4mAzl6MX3+o9dsSb5R70yC7rhTeD6JjhyknAqaRrOISgE3I1GeeN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/KHwvLVNyrUiUMkZLudq/P4CB63jvr2Kpozo3DsT8E=;
 b=dsbgIOUohZ5n9YxqcLJ5rZ6PffGZCWHGXNTyCnBJfuFR8inyAH0Lx8V52sBdSaqtXjzwKldT8j1/yfWeZMKjmSelu+XmUxoyvWAor7HQaYavgDQqllTX0wBmp6tgsCeyoUxjN/nBO8eG5kPly1yUGl3C2OLgIB0XwNxl7JWW7r92kA8fQ++EKA313n4sFdEi6G5l8a/+BgMcr26SroHW2/fos2npH+FIYnMaMlYSkPvbLALzRuXvxiurwdiG3eObBhIgqZjOmd61UL9o9obgInpKxMrAW83juA9wOSDZOCjFJ1HilSBBZhEIngbYFa72VdPR/J0Zq05ZHi8uu6AmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/KHwvLVNyrUiUMkZLudq/P4CB63jvr2Kpozo3DsT8E=;
 b=jDuo1MgyNytiQ1fecDGuMJ5dFGg4dLyYqYrzSXVBHF2w1S+UcxTRn67KZ9N/iaNvY+Txa59mL+88X2S6FjPY0EiAParS94Os24VFQ968Op0iLexqWJUGiutOv2JVDZS10m3367LHaFilztXmaXGcpXlDXKjyNIKQUftIwD2ZbIc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3575.namprd21.prod.outlook.com (2603:10b6:8:90::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.12; Tue, 23 May 2023 18:30:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.004; Tue, 23 May 2023
 18:30:54 +0000
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
Subject: RE: [PATCH v2 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to
 fix CPU online sequencing
Thread-Topic: [PATCH v2 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to
 fix CPU online sequencing
Thread-Index: AQHZjZocFsWI1H17O0ebwMrCpjsERK9oLhwg
Date:   Tue, 23 May 2023 18:30:54 +0000
Message-ID: <SA1PR21MB1335ABC2EACA80D2045ADAD1BF40A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
 <1684862062-51576-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1684862062-51576-2-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dff9870d-0dce-47fe-8329-4f9b1517efa5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T18:30:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3575:EE_
x-ms-office365-filtering-correlation-id: 28ebe8d4-bc69-4f5d-6a65-08db5bbbd83d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lb+KZgzpgz7LoUhdS8cNSvk6bx1JTN8WuXbEDF4yLrMOCDAXbqLOB9V2ey1cwt5a+gyRKfHIG6Iqinw6ngXpTzcyqymKBCIASnJAz55Fi+v99BByKNcF/t1HW5LkB6cBUkmKl18nV4nEkl2AoS0MIMkeET0FGgEXtUWDDFoz731SV9PBTwM+abK5uegICkug97KGI2CWvheEefM6Rx1wpwZYHSgTd+94t2t9ohZTl9kZkkoQv8OWNdREczKHjL0yY2WTKBoqQ3NJNG3kNj3zFJi7lZTcmopW4+LYyusyc4TmcXgo4Yn8vPpRU5TVItCOCUAATiTG0VZbIbFgBRZYhkyIilKRT8nZa3vMkmoOF1Sa9YBrhlxQJYo0iOnEGXQfSdkiBMEcBxQ0tOAcC7SRGdu7K8W7mbhWW7AB4V3fGilvIDqiZMjMTzjyDia7BcpWCS3vDJZHfeipBhWcB91dRcfMLF0gVJ5Z5xMx0q0ZmAnJiacEFyd1gfDIJX24lMn23XMjZgQn3dePwXUsh3hTimlLlt/bLH1wGH4HZfeKT4BXPT6ThBrwletWCTU6jZ84N8Tv/gl/jl6apfmBa0cxnEM8SFUEl8NQijrftroLLrhKRUer45l92P95dDx+23nthjUfioBldvLXklTmYSLpCJ9npK0lIt2OfYvkktxotoot2Qvbq68yI+Gr8b4VNnK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(8990500004)(66946007)(2906002)(4744005)(76116006)(66556008)(5660300002)(83380400001)(7416002)(52536014)(8676002)(8936002)(33656002)(786003)(316002)(110136005)(66446008)(41300700001)(64756008)(10290500003)(71200400001)(55016003)(478600001)(7696005)(66476007)(26005)(186003)(86362001)(82950400001)(82960400001)(921005)(53546011)(9686003)(6506007)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wS94olKQh0/htV6SQMcc8Bkf1ofcL0ZqMlwnIYtnyKeJgZyDss731mFuH4y?=
 =?us-ascii?Q?LVOUZaw4mdTngA2jwMLuPDwccxkGEuVbNPKjB9PNekCg2J7uiI1w+R2F2Rzw?=
 =?us-ascii?Q?OHfrBg7QbXBShNXV1CrduAO1BbvWr1b43MAh7lldDBNCXD52XmnFRid1qMU6?=
 =?us-ascii?Q?pc1pNph9TURG/1gKpUXbyVHgaE0Qnf77wdvOzKeoSI5Jh7X5AJvpmoyVd6ZS?=
 =?us-ascii?Q?XQKuuOfh1VwlmWkU5yhq63q93Y75URIrKEhbo7D73d8wD8ySY52MIZk6ySiS?=
 =?us-ascii?Q?LQB9PCjAHUxJFXTnToPhwy6cC3UP1mnrnMvIgq0UoaBFx0mJ9AdJZ8VNQCLn?=
 =?us-ascii?Q?tUvO/pselCHNWF4HT4oP1Ug8y/OBhVhK6NxkXs36WbuvegVSeU/TvLHIRr99?=
 =?us-ascii?Q?sOTHC9GM543PXTHd9cP7nx/MLcRAFY0aLktYZFRazs/jKRHeGnq7cQ8Ssaxd?=
 =?us-ascii?Q?rphYvlEr0/9ixRx+z6FNagmzO2NZ2IPUFs6k+WMLaLMpg1xq67bm/JPubJnn?=
 =?us-ascii?Q?85YQo6NeQ18XGz9LclLv8HHPempuVVoOc7MMPYdq4aT2ZP57PWUe/vn/776g?=
 =?us-ascii?Q?0hmwaajpcUNcoxpqSY1acZuebeTsWFdyb7y5Vx3MyBk+T4SZNU+0TLULrEtn?=
 =?us-ascii?Q?//TcgJVJBFwc3eszrKVHeQky9M4Cji4SCrUHbCqKSVxY+xZ9Qq//97ZO3lqs?=
 =?us-ascii?Q?fBw5/HpLGKdtCvfej/upHuBRnWzDok+MHwfvW1Cq7NY5Kicn5kLD12EGEUZw?=
 =?us-ascii?Q?XKw3b4tgJY2xjfVvZq/xyglFttp0JnMFdZ9ed3L+S4ebTWlrA2NK/p3RTAIS?=
 =?us-ascii?Q?zUOhEeQhIg/hQ0FJ1po8n+7uDzOvnN7ZpVayJ/L0ji6GCzPo5zw9lEXPRTLl?=
 =?us-ascii?Q?iOJDS1grlPgyO4bm5cSjwJg5qrqr0zdOImz1a5RmXVLeDE49Sj5Qaue2mBXm?=
 =?us-ascii?Q?Ey5+wLOYAx4au1B7NBJdSMxF8qFSdnoJBnYPZypqTw7/oUY3GnNARjZadKwa?=
 =?us-ascii?Q?Ze/a7iQ9P7NGuxFV5q7JNhqzR9jShSJZQ7tHBwxArM2gPz3oDiTysU5oH0cA?=
 =?us-ascii?Q?yYuXvFlqLcuBmCFezk0dtzMvqLAlvvU8BjO9YoUjOrAzpbXniAvQXASLJMso?=
 =?us-ascii?Q?Cth15X0YedMxFfsYMLqspxc75Z7ijwpG/NF0MtuTQLe8vhTgXHSzRMGWJJTV?=
 =?us-ascii?Q?ojdjRkAY5rZfQGjVDONsOPVSChVnwx4JfwerP26WrMGByNob+xf+/dgqjV6n?=
 =?us-ascii?Q?gkAadRlS03EVrSmytWj/4aDCykEvZl8N1mBxDjgB34hraLBQSRdeGcqEz/Di?=
 =?us-ascii?Q?SxOuXbwnEdy02da9APEpyrqEqFKBordj/U6d8BJeFZHnzIFpV2/Y7TYioA3z?=
 =?us-ascii?Q?1DKhm9VXxsiDBgaiWGtFk1wqr2gu3xUjvPX2agPtEp/3DSH3w0OoxWQYszBX?=
 =?us-ascii?Q?PsDz4o3Q9rMZ9YG7JZ33EBlzc3cxK/75DJKZUq4UrR/UC3bQC7KvHg8kX7NR?=
 =?us-ascii?Q?1EE2BoPtqzLq2R99/RuPZrSGqz9DvP2Enrz9cPuXGSUyfJNr8TmvSTIBBG7I?=
 =?us-ascii?Q?FWdPtNe4nPRtFEFke322TcM2uHUqXncz6EhNTFE/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ebe8d4-bc69-4f5d-6a65-08db5bbbd83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 18:30:54.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xi+jYRgKvfV9EhUVXyJKCOwTCboFMMrAbT0eQYvtLSDa6PBBX110747TDL/4LH9m+anuQyINhc5Tq/PcsNnd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3575
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
> Sent: Tuesday, May 23, 2023 10:14 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; catalin.marinas@arm.com; will@kernel.org;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; linux-kernel@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> x86@kernel.org
> Cc: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Subject: [PATCH v2 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE
> state to fix CPU online sequencing
>=20
> State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence
> the
> initialization of hyperv_pcpu_input_arg. Use this new state for Hyper-V
> initialization so that hyperv_pcpu_input_arg is allocated early enough.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>=20
> Changes in v2:
> * Fixed typo in commit message [Dexuan Cui]

Reviewed-by: Dexuan Cui <decui@microsoft.com>

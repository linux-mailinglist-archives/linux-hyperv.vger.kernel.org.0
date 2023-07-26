Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0489763647
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGZM0v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGZM0u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 08:26:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2110.outbound.protection.outlook.com [40.107.220.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8430C5;
        Wed, 26 Jul 2023 05:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX+gbia4tXXK9jxjpG84nQyvJ3e8J+IvxhXRQH+1h6/2MiXFkitouwTNjuXdLPUbbh5ey4lxTqkh+TblMy9dO3M6G/iZn7DCUyhP1e3HZJa0DH0KWZpSssVrNIQIJEYkXfCi0il6QGGw73BtqMGn3n+RtUB4bu/GrXGyjD6hNnuzKkpm2SngG4DYK00qeDyLUGBQd/rC/cTUDnN+AtTk32qJU3d/ny9mbJInxZThwEyJIlMPulEPoMXQohzQK+mOHBjEYBcGaDqzo2F1FdwvWl/B2TfIW9QuboHYiEeUCKR4CGErA7k4Sx8ApKo1zY5DmN+sIZZunKcTNUvgY3Ol/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLRgJ3EHGkn87XuZtviov9NukLIEjZDW5ytNacX5q9s=;
 b=dlVHTFzQ7LAfigrCJ3zvRSHNYVV3zrNGmaJXDESzTLcEd51IQ+Fu5OI7UnQXgiSJG1K5SjKMSxSrECzcfPPwaTZfVbniNuYsVTd8AG9etLDME/zEM+EXwcFGrC8jrZLNrvn1jc03Zj+tElQhmOB1OwyRyuT9XfWLVnxn65pm4kiGJzzOV8Qy9alYhB2cxrNhqiAMpi7e0+Q68xcqICENuhFTQ6l9YM86vNojPfzWP8rP+AQ6rLh0OFpkB8lV0pC8/huVE1wWvskneOc/H+CGIj8gbn7DAmbA7Ps7zGZsE71O3d1aLIIZdHeijRY9atlRQg8oqZKRj4uPj4mkw33PQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLRgJ3EHGkn87XuZtviov9NukLIEjZDW5ytNacX5q9s=;
 b=bOfBcBC9aI/RZVszj95xDdx+G8noN1qpXmMxvQ2FaYFpn+R+crMIeMib+CXw3zk4f4xAyxa90yx/z8qM3yJmTU0uiKHb8Vz1BR1syPMTugkHkG8gfacMqofGcMJFiTuh0tgwGB9bGTd4grI+KW4v5w+9jCiTJpq+PEnYbvCHOYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4057.namprd13.prod.outlook.com (2603:10b6:303:5a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:26:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:26:32 +0000
Date:   Wed, 26 Jul 2023 14:26:24 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     sharmaajay@linuxonhyperv.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v2 4/5] RDMA/mana_ib : Create Adapter - each vf bound to
 adapter object
Message-ID: <ZMEQ8NZARiqsgDDl@corigine.com>
References: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690343820-20188-5-git-send-email-sharmaajay@linuxonhyperv.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690343820-20188-5-git-send-email-sharmaajay@linuxonhyperv.com>
X-ClientProxiedBy: AS4P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 214ef07e-9bac-4bc1-3bc9-08db8dd38b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RJIwmsSMPYpfiGXMPqUeKus+/ZCWBaHkox6VM3P4JRycA3ge1sJJmFSWdrFMWnqRVFxYsH/6ibXrlTzAjZMknK4M1DJ4k5qEzt8MBO2OmA/+1OSp3ljqrO6tpT2dig/0v7vbYLn6B61sPZ956eLXcWnZcwPaG5sGNTxwSK5V3gZ3TRTvB+6AwoWhRjl0TjgIN8d8b+UrGH2V0mHzDDSsnni8iiQVOHUklMO/gq9xLy0DtlNSYpK6yvRrCmqmr9zvCsTXLzrFmPnryKNU4/SC6w8oZZkgMuIBKAySK3PnWdUABzT4uBLGyQU2B388TChrHjL8ufNJFyTBLL6m74aPbAN6umtyOftwNx7XwVeb1YJB7htI1172mc1+U3WXWRBBQioxPhnmIdbNYo6KSFOkrA4fEHsUHFkRnr/KYyVww7J7nKVlg0oagD8u7C/AtqYGDAcFpLKF6BPSgZZUiXRHPX37RQgD2T5MD1eL6w/jniO/y7WJyBxqSNPEKUlhS54Zoni3Llv/fOFpHcdsIn0sdGHz7zMlZVLXVEjKGHLtkz30VcDCKBfwH+kx7+Mjt4OT5FGnj2iW2U5rBwaByRRc6geqkBBEPwRHb95q6JIXUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(451199021)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(558084003)(36756003)(86362001)(6512007)(6506007)(45080400002)(478600001)(6666004)(6486002)(186003)(2616005)(38100700002)(6916009)(66476007)(66556008)(66946007)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VWtlWOcuZ0BEMx1a9wHiwMb4yvv4FwNJxSKspFDRvVGu5155a6fOtdgJb4Ab?=
 =?us-ascii?Q?f6fjjptgKhx9udavSqYiazVjUMFCxi0nuFIq+7baghE5a355TYJ4RRN3iURu?=
 =?us-ascii?Q?OL5RnndcX/0WBvOK7Mpzdkm/EIIzf/38qSVrM3lu6Ha6J7bfbsEU0hGSZUrN?=
 =?us-ascii?Q?MBW0CCkhtt9EKqQGt++65iUEDTDpbqKxiHao6ueQ7Jy7aVKW97uESsqdOilW?=
 =?us-ascii?Q?i4brT8upd4uOYz2ju7lcXkjutznsz9KRIb0LZleR9uop64pvqRV9lFZZvGY6?=
 =?us-ascii?Q?CbarvVDlRwg5WgmXdMIpZQSE1FICtWC+tWILw5R+WaH1UTD2pqinkGetjpUd?=
 =?us-ascii?Q?xno+FANzyvAHDm2tCj73MHN1AkYebOCkqSnwIB4p3hiUvGG3CJvisRIRTYfz?=
 =?us-ascii?Q?SWDhlahR0lkPmVxDpiu8DxCl6GyZ9l9H7EPzV9W5ew/w9sULZJowSQTw8NQ1?=
 =?us-ascii?Q?IDSLWzbopOC4J8Db/fRY54NRdVQOm0iJTugDv7qlfY+aynLFKdn2DibTV7Tz?=
 =?us-ascii?Q?beR883yRAzXIxNZRPd2KuUQeFE37+S8MqYU4PMGzv1/eOOKhWgSzJWmD/7UP?=
 =?us-ascii?Q?39cno8H1sg0ih9KzYj+hHqq6Fv4SiUaGLQ+TTLlD0kMQLUrMDSCndtaFU9dl?=
 =?us-ascii?Q?drmV3v79lZc66TPSCKC47M4tf3nUI22lrY1SDA3X7o8SU9niD1CPDbyz55Cy?=
 =?us-ascii?Q?ZYWQ7Wun6JLIUt411BZuYmWT2vpmG3ynIcStSUVmVGLYtaknDEn5jazXGr4z?=
 =?us-ascii?Q?c7PQLxGGc5j/TyfVmWeoBdPBMzrRqAarKovJ/UwECPYrV1iyxLb4NrAjoA43?=
 =?us-ascii?Q?uzrxdzkgrrvCdocjvi2OUstNyQQW5ZlcT4wlqUxNj7436P9AioTqAj7vaI+U?=
 =?us-ascii?Q?cgQg8bTSsL61NVGbGFEtbaE1gJynXHeAEIs9sRHd93yA4c5F8089OW1ZFBNS?=
 =?us-ascii?Q?+0YHM++v6mupSevKdpjcj5kJPWreDNuh8Iom2xkRHuFFAVawQtKwOWkhYX4B?=
 =?us-ascii?Q?7NDJVHk+1Rbn6Yfb2cwaYO4AKWjjA09F42fttO02pxVLcxt0KO5lGV9u3tkJ?=
 =?us-ascii?Q?p0o6RS7D1i0ikXbsuArq5Ck8jgQCMzV8Nf+y1tKrAwhkCLWk3GJOXVAMHVlc?=
 =?us-ascii?Q?KDhm2HT4QyxBxdGRgjw7e9SdSUWvCRkTiZltBNX7EjukjScfQrYWO6GnuMIW?=
 =?us-ascii?Q?UcXmtDQ6YHHV/9rtl/5MwF940G1owsdWFLjWF7MCLWZxo/KOnzdMKENz4ne+?=
 =?us-ascii?Q?88AHPlB01lhEAEspgz6MjkzUNERZBW9OShu/JYqeRfPS5ZeRY71igOz93Z2t?=
 =?us-ascii?Q?KmLdU4XP+MSxVDc3oewpCwLgVKQBmaT44bx8gEpioCSBn+N55LdAVp7CGHxk?=
 =?us-ascii?Q?ORunW3UjediZFsB51qjAYdPcVg506hgFcB12MrLOZOape4vqEA1OiLXYLrDc?=
 =?us-ascii?Q?nwYXAm3mNBfC4FoE3ODtWfTFm5cgETFIrZGO2VK7L/rlA3GIz8KeVB3Y+KW3?=
 =?us-ascii?Q?v7/o1pH8M5JTSlAiAplQHiccHF274nQ2FEilp6VKEDzcTHNxdk77s72Do7Ra?=
 =?us-ascii?Q?W8Zy6RPBQJyf4OP89wQWRKrkPOLd/lNvU2JT2gFfBMhfzSKeKrRNsFDZ88f7?=
 =?us-ascii?Q?aWVOdiV0rTFQa3Z12YIe27MnV7Ma5rWe13gMF9u0DFOmou8yo1TQLso99KcC?=
 =?us-ascii?Q?O4asoA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214ef07e-9bac-4bc1-3bc9-08db8dd38b61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:26:32.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeVPHUDNWfLqbeR4GgDyQc3IgaG55zTFi6wHQuijDBDM/Buu8JzDThJUtHjHPE3t9FQ5NEBPMWlwfMP7E2DZcm0uxo7uSApGlRmuJJQW6iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4057
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 25, 2023 at 08:56:59PM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Create adapte object to have nice container

nit: adapte -> adapter

...

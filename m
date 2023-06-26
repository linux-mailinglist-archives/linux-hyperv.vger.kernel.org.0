Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A673E01F
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFZNF1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFZNFV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 09:05:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A89B9;
        Mon, 26 Jun 2023 06:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKuy+mu5Ioi/NzkAWP45MnAI0wPcMamqRsqaQuMbitF5phylfWZAFM15/2U4tKgHz6wadkwD2fv0BmtItjIuGz7TStqJ8W6y1RV/4zE3R8fSRUlkingxRcUhZs4WEV9DI3gU5M1a76wC76pnTvLYzaWJTuQHeKVzV26l1iEyVbyd0eTW8XKikZpdu+0q0a/Ir3TBu5C47CxuWTX2V2OsEbaRjlxUysEjY0Sf2Gbfb+Gx7WufD4f+DJGbj97a2Jv9EUzE35nJzYKJiyhT2UYbD7omTboVUB5YXAb4HJg6vbOmM7QFDz0NhYUbcB7r77UWXWf/KXv/VoaIEgiprGu6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SSKU10nPSOLIg93ULzjWNsd9QrTDtZZ3qXAabIBeMQ=;
 b=fW7MRaBp7jrCA1pWAgnkfvQfN69QPG0dgayOWdo77Z9icW4NoNuIuaJ+3UQozwIoBWfcGr64QFfIg1t4UYejMoxDnpU6JO/Kjk6R97RIjVfmpzwz8Fk6RlWZO+w5qJ2PgRoB2T6LOJsIQ9SLAKc6bSzY6rKxu+/KVNBKAUM3tOgQykUAGGv/31V6ciZxhB7V3GPMXCbTYib3P9hiTEedTGrBBPAKOirBJep5DtnlBEXx55NLZDe/mJTbRFLMyydb64yoAmSd//qPMZMebvmFKV7ppNArKp/SVa/01paakOie/jWtuc6FYmsPOQOGoD8jl2q8RHsrdT76s/dcb1s9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SSKU10nPSOLIg93ULzjWNsd9QrTDtZZ3qXAabIBeMQ=;
 b=DkT36rDVgaUXBN/Ks7yC5jO2NN5w/X4kO/gfx3j5Hjf6IjtHM5xZlaK0utFTqdoCU5wPlfpxcN9KbVMBxfwuORNemnvJSZPIZGL9PmJ9Xa5pzc71voUDLmIXEJVeA9C7cXyBazpRWbSpW7TPoDd0u92LUfZZl5kLeVW1uTelT6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6337.namprd13.prod.outlook.com (2603:10b6:610:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 13:05:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 13:05:16 +0000
Date:   Mon, 26 Jun 2023 15:05:08 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJmNBKA3ygDryP7i@corigine.com>
References: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
X-ClientProxiedBy: AM0PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:208:14::40) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 707cde5a-43e8-43a2-9ccc-08db7645fc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi2LZUn+oxXQU5PdNE6RLgAZQaL9FmfK0PR7l6NqBFygXbZAj9bXWvJKjslxO9ydi49VotX2oo8e5KuODhLSLCQdx9atCZhhn5zemN7EBPvn67zwCe+2SOAMWrP3oYHJVaahS7E+JxOYWVOdriX+xZFfJAu4PudkW9Mh9jJkywjvo8kganSDcxzGiC5WvjQlR5UAg/o0hGX75S3feXWkkkcWxlHDH2n4owfZog7L8FkOV9BwOFtd+ys/qB82MfO6RBj1Ccw+EzdG46jE4Ynggf/sNaBRXL5xG/xgrLbyPbilsxvOc4rLPUA5qXuZyZt7UD72JA6fsUwvkaBUGwlu91cEPGsU+FZkJYreFd7Puk7Vr7VcHQu5xL/JJRG5B9wYkwv4Df9WuEmkCmPOlCS3ON5G+iLlQ7mpR0Gy1Gg+C2q2HoNWbZ2BHXcYmjCYcJ1jIE+NiDUbs2waYpgIsfevybmpBeG5T0356z/bSoecuPF/yc5u9punA2PFJpqdOsGGErdDvxc8PjscxOPtgexcG27eXTxOv7T/4HtAvfkJfYGHYf6TRJUbyaRgRLdwSGgF0JY4R8l6OtjL2TMjZHd4tDrBNdwIecXfSkClxy/cqY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(451199021)(2906002)(4744005)(6486002)(45080400002)(6666004)(38100700002)(2616005)(6512007)(186003)(41300700001)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(6916009)(316002)(6506007)(44832011)(7416002)(5660300002)(8676002)(8936002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//euGGiqDg7DorI1tgRW/NliooXaP67E7gEImr5ttMKRRgAb8kMcEHTt+Vv+?=
 =?us-ascii?Q?pL2PFebqbKd0YZCN93QWOjQQV2+iLhLth3rfzjp5Q/FK8xT2llxHeVUEK3Bn?=
 =?us-ascii?Q?N06ueOJ67ajOBp1cjMj4RK8EqpsauJs3EWb97I7RSNWYtVo8X73hzpgH1Nzb?=
 =?us-ascii?Q?7FflI+uAgtPQVNl88fLroR9qg1XMOJ+wkwZ/RxVKcMj+kDu1MdkFX8mnQeMf?=
 =?us-ascii?Q?xYkljKauHZFEIsaWz+jzelYKJpeXXq+A7/YS1FBQBbvxpiDsopB9u6igTApi?=
 =?us-ascii?Q?dWdZayVh5PPbnEo0E3uIW/HrfFTgQJBYCckUzU+U+e3qWnMXQzXH94s9L+p6?=
 =?us-ascii?Q?GPmPT686kpOYyEEaF8FMBrby+S99FqaNmHs6jGNMwV2hF9rXXBnf1H7L8Fq+?=
 =?us-ascii?Q?UoT6WvoM8In7uWnlmjut5vxopBuiUGyDhAdahO4/sx+VunUq9VC54BrTA08u?=
 =?us-ascii?Q?Wt11KaBMERI738XhgxpOA8hhS3dwNdrWL1UBtNor/E7wikFe24OKgxno0qr1?=
 =?us-ascii?Q?zrvJp3YrTgsFx3JZo0xilEtGzUNPoiWZeAOhx/ia1pAY60POIqBJLMiq7Xfu?=
 =?us-ascii?Q?siQrq35oQg5ekW5vJ0BPgclpmjV74BEIARvnrGEsO6zIxksV9yykkDf/6P7G?=
 =?us-ascii?Q?Q5ni4+oxIGNEIQCkST2MoRMjzR55H6CKRoikApCU+Ou5EICIIVys2iBi0RHq?=
 =?us-ascii?Q?/fMS3L2nZoKwpuC63iynts/XEK1A54GWMJEi0nNQfCttImDP5Vi2ecGI9ioR?=
 =?us-ascii?Q?mXheJbKqoXSrAVZTEIDc0+5ZtpanLxmNbMNw4ZUhbnz8dcG/y9iz1jteOdRa?=
 =?us-ascii?Q?QTJ5s09yZqKxahK5i1WXawZhVtkDbamzZAYORQfL4SxUq6gJTZFOAyytqGd1?=
 =?us-ascii?Q?XX9gWEe1bxGWc8jlKA64kMuUquYxjuxoZaL3InZ2QGEgMnaPKFyk0NTFbB9M?=
 =?us-ascii?Q?lE3y8ahcHOF1A5gY1bbFo+v4D8R2lGdB2ZlF2eWJaJgkg8SuhLO/x3HzJ4Q7?=
 =?us-ascii?Q?rPwPJgVolv4tsk81fVp6mYtN7Sm1QbdCFkdXq1EQA5P5NIPOj1Wp9pmWp8my?=
 =?us-ascii?Q?oU0OWNtfEnSgjGT0nNJiNNZHqKoc+MFxXYA22uD8PKVji8dOMO/jqvukgM7A?=
 =?us-ascii?Q?3W8O13wr8xAe0yA8NuYSgyPen4p4B3CkQhd5VN4QkakY0YPdhcZ8xki5W35h?=
 =?us-ascii?Q?tIso7tmYPvhDY3GdQ28c6QYnrx61U1syRunsFTRMu7QJPhr9M/Xr9lsqaeIW?=
 =?us-ascii?Q?P6ANdcEbKZnqkaCPtZ6ukSIaArzk27nkOQqUx6e/L0kJzfroa3wI0VCt+dB3?=
 =?us-ascii?Q?mL9eAjF+NnlpdZeL9M51MPsw+kZu0oczC+YTW73f+s5FLvtNmlXFjQCk7erJ?=
 =?us-ascii?Q?AhNoFWXLy9PSA7oA/GEsOUARA2u5EzfIBXRR5NUqYBNf8dLeTDUkNXl5nE81?=
 =?us-ascii?Q?Pq8qvkcv6YMlkDdtk6CDSffOpivWhEl3/081JO11ujL04mZF1kV5fMl+8weN?=
 =?us-ascii?Q?fiaYgSwaTndz9jR8xeQp0HwS+Zo3HUJjAIhACnOsAISA44wm/B9K+GQiKRla?=
 =?us-ascii?Q?u4fU/WJY1bXrTmzxWSt2Uvhrrimot+oCiMu6lfN3GXWqewiOoPNyfCZBWK/P?=
 =?us-ascii?Q?U4CSvPK6lFBg9KmAetDUVnbIqHumMFWP2DugIC2PFfuwBjHTzvLOdJimlqIF?=
 =?us-ascii?Q?bofYDw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707cde5a-43e8-43a2-9ccc-08db7645fc83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:05:16.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXiDuXvTDzMW4Fuyx0cgUpmq9Is78jHTN1tSMAPdopNmXKAefDyBdyT+G+fa/xDtqT74VO1AXHFebvqUjicRfGqh8ICKaXTaYQMpIORf6Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6337
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 26, 2023 at 02:18:18AM -0700, souradeep chakrabarti wrote:
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> 
> This patch addresses the VF unload issue, where mana_dealloc_queues()
> gets stuck in infinite while loop, because of host unresponsiveness.
> It adds a timeout in the while loop, to fix it.
> 
> Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a driver for
> Microsoft Azure Network Adapter)

nit: A correct format of this fixes tag is:

In particular:
* All on lone line
* Description in double quotes.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V2 -> V3:
> * Splitted the patch in two parts.
> * Removed the unnecessary braces from mana_dealloc_queues().

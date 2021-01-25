Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44032302D46
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jan 2021 22:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbhAYVJg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jan 2021 16:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbhAYVIC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 16:08:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4DC0613D6
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Jan 2021 13:07:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a12so11719093lfb.1
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Jan 2021 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXiw93fv/wmSMsIRAmki7gnl8SpEAC7+9yuH0b0xjkk=;
        b=D2E1qCLGwckT9Dt1/SsI3g43bLp+B3Zf/0C4F0us0rVz5K9I/9wDvsAygS3IyC039z
         U1Rv/druce8RPx2DKlUWLllD5LsvMN+ZFKKwXutoNYzGeMXIXOT87wan1FE6t2oxwDNx
         RSEjJWvvFMpoVgeWVKUhPyEATamC6v/CP2ACpuGjXZp3HGMql0jp/TvhbLXDboFniyj4
         IhnWuuPrRYtGnfmzoKFNadgLzFsl8dqgUQuEpGqfSZarqVwqL4Z178JcxNcbZBsdONsF
         2ulx0LkcrpSnzT5376YuUAWH/Srr9C4Hc2/m+zsDCdP236aNsj616Bc1ekImTonww7ZC
         zetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXiw93fv/wmSMsIRAmki7gnl8SpEAC7+9yuH0b0xjkk=;
        b=ILO2LedqdfgUmZrxPUm6deJkUv85WI7Ih0QUgsZVs0wMoFInsfS4eQ5fO37WrnX8LW
         c6AWRxW4354czEVkcApo9y9840TQbDtscHH3KphU/2lfDpIzu1qqwtBIKA3xaFtn0bKd
         TYQ9HVRhXoJZUr7R/QNp5M8xzY0OmEnijdQRlkb5WI2LS2Wz5ilfYm/YvJfUVjCUmUZA
         /0678f1riR776HqoDhltoBbBPzVzgii63LnYLIdz48hRWAO0yew9Ku32SxTCTDPA53oF
         TLgPp+WKVDj+9FDBam8ue41+7R7ddspbno9BB1d7fjJkuFsYa3sqBt+OPuOFrUbvbHIV
         I6wA==
X-Gm-Message-State: AOAM531a99Fn89faTU46s/RDBpau901dpv0WiooI+UqcUmeDjfmAdTP8
        AVop6pTICrUDScngVDHLMPUDb5UX+b7CA/h5e/tpm1XBnSiKzw==
X-Google-Smtp-Source: ABdhPJxxcreVBZV8lEbruv3j5FQmTi5Xqy/SOmFZ+7082wbFZ7uEzIC14xRfupl43mOppxV9YvO9IXKLgmrk3D5kuVY=
X-Received: by 2002:a05:6512:3122:: with SMTP id p2mr1025154lfd.368.1611608840091;
 Mon, 25 Jan 2021 13:07:20 -0800 (PST)
MIME-Version: 1.0
References: <CALY6xngo6fU7NoEgrmP_qtdz4OMQgKo9CiJno2uhtWie0ze3Rw@mail.gmail.com>
 <MWHPR2101MB0874A5A65BD03A5FB7857668A0BD9@MWHPR2101MB0874.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR2101MB0874A5A65BD03A5FB7857668A0BD9@MWHPR2101MB0874.namprd21.prod.outlook.com>
From:   Jon Stanley <jonstanley@gmail.com>
Date:   Mon, 25 Jan 2021 16:07:01 -0500
Message-ID: <CALY6xniUous7gsWSb4YrzOrKk138CHqaYfeZCNqG7ki97TH4qQ@mail.gmail.com>
Subject: Re: [EXTERNAL] hv_balloon issues??
To:     KY Srinivasan <kys@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 25, 2021 at 3:51 PM KY Srinivasan <kys@microsoft.com> wrote:
>
> I take it that this is on Windows Server machine. What are the Dynamic memory settings for the VM under question.

No, sorry for leaving that out. This is on Windows 10 Pro for
Workstations, on a Xeon W-2155 machine with 192GB RAM. Apologies but
I'm more of a Linux guy than Windows :). If I've gotten the wrong
thing let me know,

PS C:\Users\jonst> Get-VM -VMName build-test2 |Format-List *
<snip>
CPUUsage                            : 0
MemoryAssigned                      : 6036652032
MemoryDemand                        : 5130682368
MemoryStatus                        : OK
NumaAligned                         : False
<snip>
DynamicMemoryEnabled                : True
MemoryMaximum                       : 1099511627776
MemoryMinimum                       : 536870912

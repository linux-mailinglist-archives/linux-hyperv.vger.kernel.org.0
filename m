Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A06105DF3
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2019 02:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKVBDx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Nov 2019 20:03:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46752 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKVBDs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so5312934ljp.13
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Nov 2019 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=m913jDXRVfEU7lrY83rHrp6DULNdfWEGAoaZqXDkLTA=;
        b=pdPSpxfBL1Ad/3JxV2mSmO4/6BOLjdGP/pkx3d6hs6QjMYWgNGmqybdAf8cVPb89MZ
         7iy9H6Bwou+6jSwmM1TkH0C9Mb3il/QOlSAbnUqSfnXx9R4E3u4GoTFqXkAYmUgbtWG/
         tldohmrkjSlw5hFcoW0L9cq3GjjCoh3i9UnrYfAl89Haytv6HBQTb73zmL5Nk1fmEdxY
         H31lfYB9925iXHbcDYjLF1RNJTiR5EYdDBnU0AAQfTpg0fiXE0TuYDdFNdeBB0waW0GY
         jKh67f3p7oxgyRw2uOMO5swxmrTiGZHbsFXZ73I5CTvbVBFrzxOtnpwyrzVggFornKH6
         tDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=m913jDXRVfEU7lrY83rHrp6DULNdfWEGAoaZqXDkLTA=;
        b=YHbNOzrv27RSj5oQOx9VFhtU2EFgKpiiErV2U3SPGU4x24dxT/DPJ5ZihZroPmS+Zh
         RUKXZDN2DyrADBIlrDF3B+IA5XjbZV3EOhhpAByFE//xCKQGouTF8yDZWnHYnwiAf8QX
         aHR0GvcEEpdPLddP679pW8HbUEItKfemFfgr//qk66TL9YliQ4NiBRAQc8hIokmdFl1c
         +ZrRKtXpvYJyj82/ndssEY0smReLQ+cszfCiDIfPfo+850PSiHNmipnkOoljBSp7Dal9
         NKVal6AOf7/ZO8z6O/GTD4DAsFkRS5P7Gs11yCnANe3poLrd5hfPyIaMxE4yqUTrBApU
         83xw==
X-Gm-Message-State: APjAAAXpMKh+KE8BegAaIWE/9Hi9wFpnux+p8aFNPk+4in3Zp+qFKQ1m
        PAdFDaBwo7y7HKmrKJZ7jt59bA==
X-Google-Smtp-Source: APXvYqwnfSXY9PpKVzQQhCKshLxwXTVie+X/fnKl31b0ZdToCRb9i101bmYL66lYSpv5fqV8f+CPAQ==
X-Received: by 2002:a2e:575c:: with SMTP id r28mr9849257ljd.245.1574384626222;
        Thu, 21 Nov 2019 17:03:46 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s27sm2253515lfc.31.2019.11.21.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:45 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:03:35 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net,v2 1/2] hv_netvsc: Fix offset usage in
 netvsc_send_table()
Message-ID: <20191121170335.2f73792d@cakuba.netronome.com>
In-Reply-To: <MN2PR21MB13750EBD53CFDFCBA36CF1D8CA490@MN2PR21MB1375.namprd21.prod.outlook.com>
References: <1574372021-29439-1-git-send-email-haiyangz@microsoft.com>
        <1574372021-29439-2-git-send-email-haiyangz@microsoft.com>
        <20191121150445.47fc3358@cakuba.netronome.com>
        <MN2PR21MB13750EBD53CFDFCBA36CF1D8CA490@MN2PR21MB1375.namprd21.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 22 Nov 2019 00:54:20 +0000, Haiyang Zhang wrote:
> > >
> > > -	tab = (u32 *)((unsigned long)&nvmsg->msg.v5_msg.send_table +
> > > -		      nvmsg->msg.v5_msg.send_table.offset);
> > > +	if (offset > msglen - count * sizeof(u32)) {  
> > 
> > Can't this underflow now? What if msglen is small?  
> msglen came from the vmbus container message. We trust it to be big
> enough for the data region.

Ok, it looked like it was read from some descriptor which could
potentially be controlled by "the other side" but I trust your
judgement :)

Both patches LGTM, then.

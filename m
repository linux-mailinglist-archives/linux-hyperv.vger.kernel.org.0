Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F829D35D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Oct 2020 22:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgJ1VnG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Oct 2020 17:43:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34783 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgJ1VnF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id i6so722215lfd.1;
        Wed, 28 Oct 2020 14:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tMPZp2gGW1Ll/G7hRvYbgrAcEJlQ4MJVtT7xPcRIvB4=;
        b=p4fdMgksUs4dMZucOXpEaCDgCxZSgy/e4UnCAwKG19akQdQ8huNzMh5+VuHe4Wm/EN
         n7IwIsiN+5MIs+dIy7FVy3D+SRevl4Z//lRyDp1wQtlVRhOpe3Jww0tNok71DGEnGueL
         sXlkiW4qFBmtY9mpEAtZGnNZBhjWfokthE87WWPOpB7nfTC/vbvqYwgtInYqoLxfmDTO
         NHJFgK0wCU0oetakKkWIV//BBgZDeHCl0d+swh4dlGWiNSkVVwd4Dj47Kmj5cN0h/67I
         Jfb40c1f/QCHr6Zonr55JB3aqpCKonuQcohji4RP+FEnKooxNLqmpCqguNXS0+YKG3If
         NF+g==
X-Gm-Message-State: AOAM531MqPzsoS3D3blAjG3ylHirpCkBcSihtnVqKiMBwc8YROeW5JYP
        xMMWVl0ZtfIu/6FU4rqjdXnb/EW1HsE=
X-Google-Smtp-Source: ABdhPJzHK5PK4dU1NppRDYMBMySGxcisu6x+tk5WpHOessvQinOP+UbedEH8rlxg/Bw3+CGh2FgqjQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr9068884wrx.278.1603897035378;
        Wed, 28 Oct 2020 07:57:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m1sm6749870wmm.34.2020.10.28.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:57:14 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:57:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/33] docs: ABI: stable: remove a duplicated
 documentation
Message-ID: <20201028145712.a6yk5jxagt5tmmik@liuwe-devbox-debian-v2>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <b0138bf07d3933ce023229e718abca279c29a994.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0138bf07d3933ce023229e718abca279c29a994.1603893146.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 28, 2020 at 03:23:30PM +0100, Mauro Carvalho Chehab wrote:
> Perhaps due to a wrong cut-and-paste, this entry:
> 
> 	What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
> 
> was added twice by the same patch, one following the other.
> 
> Remove the duplication.
> 
> Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Wei Liu <wei.liu@kernel.org>

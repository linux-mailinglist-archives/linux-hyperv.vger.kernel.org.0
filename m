Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D092D0EF8
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Dec 2020 12:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLGL0P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Dec 2020 06:26:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgLGL0P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Dec 2020 06:26:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id v14so11164814wml.1;
        Mon, 07 Dec 2020 03:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfmcboZckOdLWRQK3WBau3Vthufoea/kKtobK7JGmPg=;
        b=nz/Ct9zxqnbCtzBG32DKW/ZRMCWM74SOz2j7Ql3k18eT73mxqxcWHUuCQisNdKf4DC
         fzaCCoMNzrxjr2Y5jzATAWfiv9dEHBaJ5LQSuVn2Lart+o2zTGsWcb5lM98ordP4eIZW
         3PXnE36VayOYTdzGqbIAzPczWIyh57nE6lbNGRIWQBc1+zCVOapKbkT8XODtxxNPX7GP
         Dj1qQiB2bCxUIaFecIxFQNVxCzkcuv3HgCkMQa5KF+qAQ0C73pXL0vObX7xAkUFe+lt9
         yDOKWCcbSXpckufRugTPR9QQqg6bk6P49XAJefTUXoI359W3BpBAoKnq8vU1Afcoyvc9
         rqgg==
X-Gm-Message-State: AOAM533xjb4RWMtoYAurbhGcc4OH7FcVFa1Vrwl/UgJ0XPTZnlELdPP/
        Wr2jqzYTFKNyHPctcdRzNSE=
X-Google-Smtp-Source: ABdhPJw8llf8dkv6OsfI4BSs0d83qov7QbuSlkh81Aa8V9j8dJ3pqUUYa50qOUvlMXdH7p8UzAXWAg==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr18110994wmf.34.1607340333953;
        Mon, 07 Dec 2020 03:25:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h15sm9690339wru.4.2020.12.07.03.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:25:33 -0800 (PST)
Date:   Mon, 7 Dec 2020 11:25:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Max Stolze <max.stolze@fau.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH] drivers/hv: remove obsolete TODO and fix misleading typo
 in comment
Message-ID: <20201207112531.uyacqporhjk26hki@liuwe-devbox-debian-v2>
References: <MW2PR2101MB1052B86A1C6C9A64E8DDBA6ED7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20201206104850.24843-1-stefan.eschenbacher@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206104850.24843-1-stefan.eschenbacher@fau.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 06, 2020 at 11:48:50AM +0100, Stefan Eschenbacher wrote:
> Removes an obsolete TODO in the VMBus module and fixes a misleading typo
> in the comment for the macro MAX_NUM_CHANNELS, where two digits have been
> twisted.
> 
> Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
> Co-developed-by: Max Stolze <max.stolze@fau.de>
> Signed-off-by: Max Stolze <max.stolze@fau.de>

Applied to hyperv-next. Thanks.

Wei.

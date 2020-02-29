Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F01749DB
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Feb 2020 23:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgB2Wsd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 Feb 2020 17:48:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2Wsd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 Feb 2020 17:48:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id e10so6384486wrr.10;
        Sat, 29 Feb 2020 14:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bnQfnjDKjbuLk4iXEXKVzU4cM8t78hJujods7dtdoDY=;
        b=MC94tTx30OOsidG2bXTG8W7lE/bx42mktdPBpYKWt3jvi6tlJ6o1DcAs04yP9MCJF3
         7gef8tsUsIIUkjrc4VGu7AIl4svpCniHzO1PVqWv3f5j3KXDg+t6w8lYzAmne/UFs1bQ
         kY/66axeLXtXb6vYRoCVGp5rYNBpRjJQY0MXwO/MeP2gDCfgw0iEsVFRcvbLPDWpf8yi
         uxQnFB57Kc1KlBNiTNgqnul8ENOl7HFlbyZdVQX/+h340mBkXoL6tY9fSS92aMZhIfMF
         ykHrWpzwxS6y6Uh4EPs8cIm95AtWwsmQXIM+dkq2r/kLhPGmhIPY1AYZHK38ZY7a/hjh
         r1vg==
X-Gm-Message-State: APjAAAVel8uilhsPdgye7qC6s5T74AU5iMlAljER2YdzMuuNwCEmST0S
        wA/gX6eNe3CT72uQGQimbGk=
X-Google-Smtp-Source: APXvYqz6nrk84CxcrOh2MlSn5TAAkrZg4dAqU73gg891ydj0/+V5JKrkpMVbXt6vx2rpwm5lVdMkqg==
X-Received: by 2002:a5d:5301:: with SMTP id e1mr11617231wrv.44.1583016511090;
        Sat, 29 Feb 2020 14:48:31 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id d17sm7845287wmb.36.2020.02.29.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 14:48:30 -0800 (PST)
Date:   Sat, 29 Feb 2020 22:48:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
Message-ID: <20200229224828.pnbtco2f6shvy2vh@debian>
References: <20200229173007.61838-1-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229173007.61838-1-tanure@linux.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Feb 29, 2020 at 05:30:07PM +0000, Lucas Tanure wrote:
> Fix below warnings reported by coccicheck:
> drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
